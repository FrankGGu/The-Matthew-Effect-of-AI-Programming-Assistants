-spec min_operations_to_make_median_k(Nums :: [integer()], K :: integer()) -> integer().
min_operations_to_make_median_k(Nums, K) ->
    Sorted = lists:sort(Nums),
    Len = length(Sorted),
    MedianPos = Len div 2,
    Median = lists:nth(MedianPos + 1, Sorted),
    if
        Median =:= K ->
            0;
        true ->
            Diff = abs(K - Median),
            Operations = Diff,
            if
                K < Median ->
                    Sum = lists:sum([abs(N - K) || N <- lists:sublist(Sorted, MedianPos + 1, Len - MedianPos - 1)]),
                    Operations + Sum;
                true ->
                    Sum = lists:sum([abs(N - K) || N <- lists:sublist(Sorted, 1, MedianPos)]),
                    Operations + Sum
            end
    end.