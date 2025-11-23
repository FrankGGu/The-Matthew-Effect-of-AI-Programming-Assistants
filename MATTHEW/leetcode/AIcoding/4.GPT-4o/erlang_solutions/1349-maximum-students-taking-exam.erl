-module(solution).
-export([maxStudents/1]).

maxStudents(Seats) ->
    Rows = length(Seats),
    Columns = length(hd(Seats)),
    MaxStudents = max_students(Seats, Rows, Columns, 0),
    MaxStudents.

max_students(_, 0, _, Acc) -> Acc;
max_students(Seats, R, C, Acc) ->
    case can_place(Seats, R, C) of
        true ->
            NewSeats = place_student(Seats, R, C),
            max_students(NewSeats, R - 1, C, Acc + 1);
        false ->
            max_students(Seats, R - 1, C, Acc)
    end.

can_place(Seats, R, C) ->
    (element(R, Seats) =:= 0) andalso
    (C == 1 orelse element(R, Seats) =:= 0).

place_student(Seats, R, C) ->
    NewRow = lists:replace(C, 1, element(R, Seats)),
    lists:replace(R, NewRow, Seats).