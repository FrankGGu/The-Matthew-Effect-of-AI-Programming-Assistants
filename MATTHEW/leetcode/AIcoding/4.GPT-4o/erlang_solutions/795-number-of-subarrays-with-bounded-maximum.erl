-module(solution).
-export([numSubarrayBoundedMax/3]).

numSubarrayBoundedMax(A, L, R) ->
    count_subarrays(A, R) - count_subarrays(A, L - 1).

count_subarrays([], _) -> 0;
count_subarrays([H | T], Bound) ->
    if
        H > Bound -> 0;
        true -> 1 + count_subarrays(T, Bound)
    end + count_subarrays(T, Bound).