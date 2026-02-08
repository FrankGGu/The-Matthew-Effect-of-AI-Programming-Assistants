-module(solution).
-export([find_beautiful_indices/1]).

find_beautiful_indices(Arr) ->
    N = length(Arr),
    lists:filter(fun(Index) -> beautiful_index(Index, Arr, N) end, lists:seq(1, N)).

beautiful_index(Index, Arr, N) ->
    LeftSum = lists:sum(lists:sublist(Arr, 1, Index - 1)),
    RightSum = lists:sum(lists:sublist(Arr, Index + 1, N - Index)),
    LeftSum =:= RightSum.