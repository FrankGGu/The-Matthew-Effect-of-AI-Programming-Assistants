-module(solution).
-export([numOfSubarrays/3]).

numOfSubarrays(A, K, threshold) ->
    Total = lists:sum(A),
    Target = K * threshold,
    count_subarrays(A, K, Total, Target, 0, 0).

count_subarrays(_, 0, _, _, Count, Acc) when Acc >= 0 -> Count + 1;
count_subarrays([], _, _, _, Count, _) -> Count;
count_subarrays([H | T], K, Total, Target, Count, Acc) ->
    NewAcc = Acc + H,
    if
        length(T) + 1 < K -> Count;
        length(T) + 1 == K -> count_subarrays([], 0, Total, Target, Count, NewAcc);
        true -> 
            count_subarrays(T, K, Total, Target, count_subarrays([H | T], K - 1, Total, Target, Count, NewAcc), NewAcc)
    end.