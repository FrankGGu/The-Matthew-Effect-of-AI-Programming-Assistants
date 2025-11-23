-module(rotate_function).
-export([maxRotateFunction/1]).

maxRotateFunction(Nums) ->
    N = length(Nums),
    if
        N == 0 -> 0;
        true ->
            Sum = lists:sum(Nums),
            F = 0,
            rotate_function(Nums, N, Sum, F, 0)
    end.

rotate_function(_, _, _, F, N) when N == 0 -> F;
rotate_function(Nums, N, Sum, F, K) ->
    NextF = F + Sum - N * lists:nth(N - K, Nums),
    rotate_function(Nums, N, Sum, NextF, K + 1).