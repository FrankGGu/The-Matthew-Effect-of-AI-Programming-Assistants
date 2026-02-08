-module(subarray_sums_divisible_by_k).
-export([subarraysDivByK/2]).

subarraysDivByK(A, K) ->
    Map = #{0 => 1},
    Count = 0,
    Sum = 0,
    lists:foldl(fun(N, {Map1, Count1, Sum1}) ->
        Sum2 = (Sum1 + N) rem K,
        Case = case maps:get(Sum2, Map1, 0) of
            V when V > 0 -> {maps:put(Sum2, V + 1, Map1), Count1 + V, Sum2};
            _ -> {maps:put(Sum2, 1, Map1), Count1, Sum2}
        end,
        Case
    end, {Map, Count, Sum}, A),
    {_, Count, _} = lists:foldl(fun(N, {Map1, Count1, Sum1}) ->
        Sum2 = (Sum1 + N) rem K,
        Case = case maps:get(Sum2, Map1, 0) of
            V when V > 0 -> {maps:put(Sum2, V + 1, Map1), Count1 + V, Sum2};
            _ -> {maps:put(Sum2, 1, Map1), Count1, Sum2}
        end,
        Case
    end, {Map, Count, Sum}, A),
    Count.