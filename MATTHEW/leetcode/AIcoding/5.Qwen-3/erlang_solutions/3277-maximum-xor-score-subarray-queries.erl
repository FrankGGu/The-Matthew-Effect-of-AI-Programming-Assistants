-module(max_xor_score_subarray_queries).
-export([maxSubarrayXOR/2]).

maxSubarrayXOR(Nums, Queries) ->
    lists:map(fun(Q) -> solve(Q, Nums) end, Queries).

solve({L, R}, Nums) ->
    Max = lists:foldl(fun(I, Acc) -> max(Acc, xor_subarray(L, R, I, Nums)) end, 0, lists:seq(0, length(Nums) - 1)),
    Max.

xor_subarray(L, R, Start, Nums) ->
    if
        Start > R -> 0;
        true ->
            lists:foldl(fun(I, Acc) -> Acc bxor element(I + 1, Nums) end, 0, lists:seq(L, R))
    end.