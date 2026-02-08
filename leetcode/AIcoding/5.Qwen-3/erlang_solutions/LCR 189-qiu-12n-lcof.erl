-module(solution).
-export([accumulator/1]).

accumulator(Nums) ->
    Acc = 0,
    lists:foldl(fun(X, A) -> A + X end, Acc, Nums).