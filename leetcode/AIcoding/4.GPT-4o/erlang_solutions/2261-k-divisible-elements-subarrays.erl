-module(solution).
-export([count_divisible_subarrays/2]).

count_divisible_subarrays(N, K) ->
    List = lists:seq(1, N),
    count_divisible_subarrays_helper(List, K, 0, 0).

count_divisible_subarrays_helper([], _, Count, _) -> Count;
count_divisible_subarrays_helper([H | T], K, Count, CurrentSum) ->
    NewSum = CurrentSum + H,
    NewCount = if NewSum rem K == 0 -> Count + 1; true -> Count end,
    count_divisible_subarrays_helper(T, K, NewCount, NewSum).