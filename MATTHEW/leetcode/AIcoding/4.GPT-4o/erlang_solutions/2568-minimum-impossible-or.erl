-module(solution).
-export([minimum_impossible_or/1]).

minimum_impossible_or(List) ->
    Max = lists:max(List),
    1 bsl lists:foldl(fun(X, Acc) -> Acc bor (X band (bnot Acc)) end, 0, List) + 1.