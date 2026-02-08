-spec smallest_range_i(Nums :: [integer()], K :: integer()) -> integer().
smallest_range_i(Nums, K) ->
    Min = lists:min(Nums),
    Max = lists:max(Nums),
    case (Max - K) - (Min + K) of
        Diff when Diff < 0 -> 0;
        Diff -> Diff
    end.