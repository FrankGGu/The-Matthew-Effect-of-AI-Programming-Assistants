-spec minimum_score(Nums :: [integer()], K :: integer()) -> integer().
minimum_score(Nums, K) ->
    Sorted = lists:sort(Nums),
    Min = lists:nth(1, Sorted),
    Max = lists:last(Sorted),
    case (Max - K) - (Min + K) of
        Diff when Diff =< 0 -> 0;
        Diff -> Diff
    end.