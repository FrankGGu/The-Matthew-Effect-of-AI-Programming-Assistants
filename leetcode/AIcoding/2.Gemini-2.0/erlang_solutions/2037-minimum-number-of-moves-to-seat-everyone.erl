-module(minimum_moves_to_seat_everyone).
-export([min_moves/2]).

min_moves(Seats, Students) ->
    SortedSeats = lists:sort(Seats),
    SortedStudents = lists:sort(Students),
    min_moves_helper(SortedSeats, SortedStudents, 0).

min_moves_helper([], [], Acc) ->
    Acc;
min_moves_helper([Seat | SeatsTail], [Student | StudentsTail], Acc) ->
    Diff = abs(Seat - Student),
    min_moves_helper(SeatsTail, StudentsTail, Acc + Diff).