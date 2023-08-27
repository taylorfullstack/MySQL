-- @block Create the Users table, which includes hosts and guests
CREATE TABLE Users(
  id INT PRIMARY KEY AUTO_INCREMENT,
  email VARCHAR(255) NOT NULL UNIQUE,
  bio TEXT,
  country VARCHAR(2)
);
-- @block Add users to the Users table
INSERT INTO Users (email, bio, country)
VALUES 
  ('host@rentals.com', 'I am an airbnb host', 'BE'),
  ('tester@test.com', 'I am a test user', 'UK'),
  ('hello@world.com', 'Hello world', 'MX'),
  ('figma@design.com', 'I heart Figma', 'CA'),
  ('react@js.com', 'Click me', 'FR'),
  ('node@server.net', 'JavaScript is a backend language', 'US');
-- @block Index the Users' email column
CREATE INDEX email_index ON Users (email);
-- @block Create the Rooms table
CREATE TABLE Rooms(
  id INT AUTO_INCREMENT,
  street VARCHAR(255),
  owner_id INT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (owner_id) REFERENCES Users(id)
);
-- @block Add rooms to the Rooms table
INSERT INTO Rooms (owner_id, street)
VALUES 
  (1, '123 1st Street'),
  (1, '456 2nd Avenue'),
  (1, '789 3rd Boulevard'),
  (1, '1011 4th Court'),
  (1, '1213 5th Drive'),
  (1, '1415 6th Parkway');

-- @block Inner join to get the rooms owned by a user
SELECT * FROM Users
INNER JOIN Rooms 
ON Rooms.owner_id = Users.id;

-- @block Left join to get all users, even if they don't own a room
SELECT * FROM Users
LEFT JOIN Rooms 
ON Rooms.owner_id = Users.id;

-- @block Right join to get all rooms, even if they don't have an owner
SELECT * FROM Users
RIGHT JOIN Rooms 
ON Rooms.owner_id = Users.id;

-- @block Cast columns to a different name, with underscores to make the name friendly with languages that use dot notation
SELECT
  Users.id AS user_id,
  Rooms.id AS room_id,
  email,
  street 
FROM Users
INNER JOIN Rooms 
ON Rooms.owner_id = Users.id;

--Booking table allows relationships where a user has many rooms booked, or a room has been booked many times
-- @block Create the Bookings table
CREATE TABLE Bookings(
  id INT AUTO_INCREMENT,
  guest_id INT NOT NULL,
  room_id INT NOT NULL,
  check_in DATETIME,
  PRIMARY KEY (id),
  FOREIGN KEY (room_id) REFERENCES Rooms(id),
  FOREIGN KEY (guest_id) REFERENCES Users(id)
);

-- @block Add bookings to the Bookings table
INSERT INTO Bookings (guest_id, room_id, check_in)
VALUES(1, 2, '2023-01-01 00:00:00');

-- @block Add bookings to the Bookings table
INSERT INTO Bookings (guest_id, room_id, check_in)
VALUES(5, 2, '2023-01-01 00:00:00');

-- @block All the rooms an owner has booked
SELECT 
  Bookings.guest_id,
  Rooms.street, 
  Bookings.check_in 
FROM Bookings
INNER JOIN Rooms ON Rooms.id = Bookings.room_id
WHERE Rooms.owner_id = 1;

-- @block All the rooms a user has booked
SELECT 
  Bookings.guest_id,
  Rooms.street, 
  Bookings.check_in
FROM Bookings
INNER JOIN Rooms ON Rooms.id = Bookings.room_id
WHERE Bookings.guest_id = 5;

-- @block All the users who have booked a room
SELECT
  room_id,
  guest_id, 
  email, 
  bio
FROM bookings
INNER JOIN Users ON Users.id = Bookings.guest_id
WHERE room_id = 2;

-- To delete a table
-- DROP TABLE <table_name>;