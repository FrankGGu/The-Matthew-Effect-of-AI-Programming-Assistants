-module(solution).
-export([count_subarrays/2]).

count_subarrays(A, K) ->
    count_subarrays(A, K, 0, 0, 0).

count_subarrays([], _, _, Count, _) -> Count;
count_subarrays([H | T], K, Sum, Count, Start) ->
    Sum1 = Sum + H,
    case Sum1 < K of
        true ->
            count_subarrays(T, K, Sum1, Count + (length([H | T]) + Start), Start);
        false ->
            count_subarrays(T, K, Sum1 - H, Count, Start + 1)
    end.