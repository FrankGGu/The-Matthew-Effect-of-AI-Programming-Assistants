-module(solution).
-export([maximum_xor/1]).

maximum_xor(Nums) ->
    Max = lists:foldl(fun(X, Acc) -> X bxor Acc end, 0, Nums),
    Max.