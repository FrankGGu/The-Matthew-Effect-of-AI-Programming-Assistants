-module(solution).
-export([for_k_subarrays/2]).

for_k_subarrays(Nums, K) ->
    N = length(Nums),
    Results = lists:seq(0, N - K),
    lists:map(fun(I) -> power_subarray(Nums, I, K) end, Results).

power_subarray(Nums, I, K) ->
    Sub = lists:sublist(Nums, I + 1, K),
    lists:foldl(fun(X, Acc) -> Acc * X end, 1, Sub).