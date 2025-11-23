-spec smallest_range_ii(Nums :: [integer()], K :: integer()) -> integer().
smallest_range_ii(Nums, K) ->
    Sorted = lists:sort(Nums),
    N = length(Sorted),
    Min = lists:nth(1, Sorted),
    Max = lists:nth(N, Sorted),
    Initial = Max - Min,
    lists:foldl(fun(I, Acc) ->
        A = lists:nth(I, Sorted),
        B = lists:nth(I + 1, Sorted),
        High = max(Max - K, A + K),
        Low = min(Min + K, B - K),
        min(Acc, High - Low)
    end, Initial, lists:seq(1, N - 1)).