-module(min_moves_to_seat).
-export([minMovesToSeat/2]).

minMovesToSeat(Seats, Students) ->
    SortedSeats = lists:sort(Seats),
    SortedStudents = lists:sort(Students),
    lists:sum(lists:zipwith(fun(S, St) -> abs(S - St) end, SortedSeats, SortedStudents)).