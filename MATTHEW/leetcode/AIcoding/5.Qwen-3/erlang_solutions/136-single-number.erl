-module(solve).
-export([single_number/1]).

single_number(Nums) ->
    lists:foldl(fun(X, Acc) -> Acc bxor X end, 0, Nums).