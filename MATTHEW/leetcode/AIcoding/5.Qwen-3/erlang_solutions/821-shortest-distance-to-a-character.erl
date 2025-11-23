-module(solution).
-export([shortest_distance/2]).

shortest_distance(Str, Char) ->
    N = length(Str),
    Result = lists:seq(0, N-1),
    lists:map(fun(I) -> shortest_distance_helper(Str, Char, I, N) end, Result).

shortest_distance_helper(Str, Char, I, N) ->
    Min = lists:min([abs(I - J) || J <- lists:seq(0, N-1), lists:nth(J+1, Str) == Char]),
    Min.