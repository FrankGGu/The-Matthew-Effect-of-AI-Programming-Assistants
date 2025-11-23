-spec min_moves_to_seat(Seats :: [integer()], Students :: [integer()]) -> integer().
min_moves_to_seat(Seats, Students) ->
    SortedSeats = lists:sort(Seats),
    SortedStudents = lists:sort(Students),
    lists:sum([abs(S - St) || {S, St} <- lists:zip(SortedSeats, SortedStudents)]).