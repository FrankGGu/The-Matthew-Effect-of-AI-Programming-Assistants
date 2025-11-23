-module(solution).
-export([singleNumber/1]).

singleNumber(Nums) ->
    lists:foldl(fun(X, Acc) -> X bxor Acc end, 0, Nums).