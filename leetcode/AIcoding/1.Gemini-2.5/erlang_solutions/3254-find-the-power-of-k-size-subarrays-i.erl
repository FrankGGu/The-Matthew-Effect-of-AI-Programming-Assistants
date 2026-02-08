-module(solution).
-export([find_power_of_k_size_subarrays_i/2]).

-spec find_power_of_k_size_subarrays_i(Nums :: [integer()], K :: integer()) -> [integer()].
find_power_of_k_size_subarrays_i(Nums, K) when K =< 0 -> [];
find_power_of_k_size_subarrays_i(Nums, K) ->
    N = length(Nums),
    if N < K ->
        [];
    true ->
        find_power_of_k_size_subarrays_i(Nums, K, 1, N, [])
    end.

find_power_of_k_size_subarrays_i(Nums, K, CurrentStartIdx, TotalLen, Acc) ->
    CurrentEndIdx = CurrentStartIdx + K - 1,
    if CurrentEndIdx > TotalLen ->
        lists:reverse(Acc);
    true ->
        Subarray = lists:sublist(Nums, CurrentStartIdx, K),
        Power = lists:sum(Subarray),
        find_power_of_k_size_subarrays_i(Nums, K, CurrentStartIdx + 1, TotalLen, [Power | Acc])
    end.