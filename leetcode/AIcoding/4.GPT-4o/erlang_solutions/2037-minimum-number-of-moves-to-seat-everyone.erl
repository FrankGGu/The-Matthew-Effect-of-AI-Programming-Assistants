-module(solution).
-export([min_moves/2]).

min_moves(Seatings, People) ->
    SortedSeatings = lists:sort(Seatings),
    SortedPeople = lists:sort(People),
    lists:foldl(fun({S, P}, Acc) -> Acc + abs(S - P) end, 0, lists:zip(SortedSeatings, SortedPeople)).