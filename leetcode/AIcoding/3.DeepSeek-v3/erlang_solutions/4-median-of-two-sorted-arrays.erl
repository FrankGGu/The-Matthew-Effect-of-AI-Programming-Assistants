find_median_sorted_arrays(A, B) ->
    LenA = length(A),
    LenB = length(B),
    Total = LenA + LenB,
    case Total rem 2 of
        1 -> find_kth(A, B, Total div 2 + 1);
        0 -> (find_kth(A, B, Total div 2) + find_kth(A, B, Total div 2 + 1)) / 2.0
    end.

find_kth(A, B, K) ->
    LenA = length(A),
    LenB = length(B),
    if
        LenA > LenB -> find_kth(B, A, K);
        LenA == 0 -> lists:nth(K, B);
        K == 1 -> min(hd(A), hd(B));
        true ->
            PA = min(K div 2, LenA),
            PB = K - PA,
            case lists:nth(PA, A) of
                AVal when AVal =< lists:nth(PB, B) ->
                    find_kth(lists:nthtail(PA, A), B, K - PA);
                _ ->
                    find_kth(A, lists:nthtail(PB, B), K - PB)
            end
    end.