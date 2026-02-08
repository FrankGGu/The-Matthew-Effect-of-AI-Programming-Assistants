-module(solution).
-export([isGoodArray/1]).

isGoodArray(Nums) ->
    lists:foldl(fun(X, Acc) -> math:gcd(X, Acc) end, hd(Nums), tl(Nums)) == 1.