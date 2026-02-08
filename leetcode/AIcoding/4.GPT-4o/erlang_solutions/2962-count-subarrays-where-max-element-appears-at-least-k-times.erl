-module(solution).
-export([count_subarrays/2]).

count_subarrays(A, K) ->
    N = length(A),
    count_subarrays_helper(A, K, N, 0, 0, 0).

count_subarrays_helper([], _, _, _, _, Result) -> Result;
count_subarrays_helper([H | T], K, N, MaxCount, CurrentCount, Result) ->
    NewCount = if H == MaxCount -> CurrentCount + 1; true -> 1 end,
    {NewMaxCount, NewResult} = if NewCount >= K -> {H, Result + NewCount}; true -> {MaxCount, Result} end,
    count_subarrays_helper(T, K, N, NewMaxCount, NewCount, NewResult).