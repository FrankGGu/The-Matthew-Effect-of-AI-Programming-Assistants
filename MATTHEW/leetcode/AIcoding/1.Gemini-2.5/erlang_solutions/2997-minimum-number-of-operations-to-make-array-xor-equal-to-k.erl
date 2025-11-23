-module(solution).
-export([minOperations/2]).

minOperations(Nums, K) ->
    InitialXorSum = lists:foldl(fun(Num, Acc) -> Num bxor Acc end, 0, Nums),
    RequiredFlips = InitialXorSum bxor K,
    count_set_bits(RequiredFlips).

count_set_bits(N) ->
    count_set_bits(N, 0).

count_set_bits(0, Count) ->
    Count;
count_set_bits(N, Count) when N > 0 ->
    count_set_bits(N band (N - 1), Count + 1).