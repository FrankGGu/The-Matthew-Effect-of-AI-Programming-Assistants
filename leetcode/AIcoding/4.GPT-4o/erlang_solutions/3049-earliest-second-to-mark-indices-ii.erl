-module(solution).
-export([earliest_second/2]).

earliest_second(Indices, N) ->
    SortedIndices = lists:sort(Indices),
    earliest_second_helper(SortedIndices, N, 0, 0).

earliest_second_helper([], _, Prev, Count) -> 
    Count;
earliest_second_helper([H | T], N, Prev, Count) when H > Prev ->
    earliest_second_helper(T, N, H, Count + 1);
earliest_second_helper([H | T], N, Prev, Count) when H =< Prev ->
    earliest_second_helper(T, N, Prev, Count).