-module(solution).
-export([count_interesting_subarrays/2]).

count_interesting_subarrays(A, k) ->
    Count = length(A),
    InterestingCount = count_interesting_subarrays_helper(A, k, 0, 0, #{}, Count),
    InterestingCount.

count_interesting_subarrays_helper([], _, _, _, _, Count) -> 
    Count;
count_interesting_subarrays_helper([H | T], K, PrefixSum, InterestingCount, Seen, Count) ->
    NewPrefixSum = PrefixSum + (if H rem 2 == 1 -> 1; true -> 0 end),
    NewInterestingCount = maps:get(NewPrefixSum - K, Seen, 0) + InterestingCount,
    NewSeen = maps:update(NewPrefixSum, fun(Val) -> Val + 1 end, 1, Seen),
    count_interesting_subarrays_helper(T, K, NewPrefixSum, NewInterestingCount, NewSeen, Count + NewInterestingCount).