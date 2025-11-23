-module(solution).
-export([number_of_sets/1]).

number_of_sets(Branches) ->
    Max = lists:max(Branches),
    Count = lists:foldl(fun(X, Acc) -> if X == Max -> Acc + 1; true -> Acc end end, 0, Branches),
    Count.