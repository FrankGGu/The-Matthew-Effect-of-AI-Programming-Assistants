-module(solution).
-export([concatenation_sum/1]).

concatenation_sum(Numbers) ->
    Concatenated = lists:foldl(fun(Number, Acc) -> [Number | Acc] end, [], Numbers),
    Sum = lists:foldl(fun(Number, Acc) -> Acc + Number end, 0, Concatenated),
    Sum.