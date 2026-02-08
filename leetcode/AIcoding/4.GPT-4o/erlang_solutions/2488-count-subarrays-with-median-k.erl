-module(solution).
-export([count_subarrays_with_median_k/2]).

count_subarrays_with_median_k(List, K) ->
    Count = count_subarrays(List, K, 0, 0, 0, 0),
    Count.

count_subarrays([], _, _, _, Count, _) -> Count;
count_subarrays([H | T], K, Left, Right, Count, Total) ->
    NewCount = case H of
        X when X < K -> count_subarrays(T, K, Left + 1, Right, Count, Total);
        X when X > K -> count_subarrays(T, K, Left, Right + 1, Count, Total);
        _ -> Count + Left + 1 + Total + count_subarrays(T, K, Left, Right, 0, Count)
    end,
    NewCount.