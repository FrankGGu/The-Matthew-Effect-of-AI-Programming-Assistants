-spec min_moves_to_seat(Seats :: [integer()], Students :: [integer()]) -> integer().
min_moves_to_seat(Seats, Students) ->
    SortedSeats = lists:sort(Seats),
    SortedStudents = lists:sort(Students),
    Pairs = lists:zip(SortedSeats, SortedStudents),
    lists:foldl(fun({Seat, Student}, Acc) ->
                        Acc + abs(Seat - Student)
                end, 0, Pairs).