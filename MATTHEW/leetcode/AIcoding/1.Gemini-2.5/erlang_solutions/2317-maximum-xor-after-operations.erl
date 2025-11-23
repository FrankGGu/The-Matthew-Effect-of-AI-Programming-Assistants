-module(solution).
-export([maximumXOR/1]).

maximumXOR(Nums) ->
    lists:foldl(fun(X, Acc) -> X bor Acc end, 0, Nums).