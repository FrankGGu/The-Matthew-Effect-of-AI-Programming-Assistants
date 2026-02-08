-module(solution).
-export([number_of_nice_subarrays/2]).

number_of_nice_subarrays(A, K) ->
    count_nice_subarrays(A, K) - count_nice_subarrays(A, K - 1).

count_nice_subarrays([], _) -> 0;
count_nice_subarrays(A, K) ->
    count_helper(A, K, 0, 0, 0).

count_helper([], _, _, Count, _) -> Count;
count_helper([H | T], K, OddCount, Count, Start) ->
    NewOddCount = if H rem 2 =:= 1 -> OddCount + 1; true -> OddCount end,
    NewCount = if NewOddCount =:= K -> Count + 1; NewOddCount > K -> Count + 1; true -> Count end,
    count_helper(T, K, NewOddCount, NewCount, Start + 1).