-module(solution).
-export([find_array_concatenation_value/1]).

find_array_concatenation_value(Array) ->
    Length = length(Array),
    Concatenated = lists:foldl(fun(X, Acc) -> Acc * 10 + X end, 0, Array) + lists:foldl(fun(X, Acc) -> Acc * 10 + X end, 0, lists:reverse(Array)),
    Concatenated.