-module(permutation_sequence).
-export([get_permutation/2]).

get_permutation(N, K) ->
    Nums = lists:seq(1, N),
    get_permutation_helper(Nums, K, []).

get_permutation_helper(Nums, K, Acc) ->
    Len = length(Nums),
    if Len == 0 ->
        lists:flatten(Acc);
    true ->
        Factorial = factorial(Len - 1),
        Index = (K - 1) div Factorial,
        NextK = K - Index * Factorial,
        NextNum = lists:nth(Index + 1, Nums),
        NextNums = lists:delete(NextNum, Nums),
        get_permutation_helper(NextNums, NextK, Acc ++ [integer_to_list(NextNum)])
    end.

factorial(0) -> 1;
factorial(N) -> N * factorial(N - 1).