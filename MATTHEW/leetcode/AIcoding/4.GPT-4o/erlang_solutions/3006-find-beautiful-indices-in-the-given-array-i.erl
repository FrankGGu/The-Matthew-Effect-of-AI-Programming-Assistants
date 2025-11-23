-module(solution).
-export([find_beautiful_indices/1]).

find_beautiful_indices(Array) ->
    N = length(Array),
    lists:filter(fun(Index) -> is_beautiful(Index, Array, N) end, lists:seq(0, N - 1)).

is_beautiful(Index, Array, N) ->
    LeftSum = lists:sum(lists:sublist(Array, 1, Index)),
    RightSum = lists:sum(lists:sublist(Array, Index + 2, N - Index - 1)),
    LeftSum =:= RightSum.