-module(max_xor_for_each_query).
-export([findMaximumXOR/1]).

findMaximumXOR(Nums) ->
    Max = lists:foldl(fun(X, Acc) -> max(X, Acc) end, 0, Nums),
    Result = lists:map(fun(N) -> N bxor Max end, Nums),
    Result.