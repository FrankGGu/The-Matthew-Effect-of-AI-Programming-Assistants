-spec min_index_valid_split(Nums :: [integer()]) -> integer().
min_index_valid_split(Nums) ->
    Dominant = find_dominant(Nums),
    Total = count_occurrences(Nums, Dominant),
    {MinIndex, _, _} = lists:foldl(
        fun(X, {Index, Count, Min}) ->
            NewCount = if X == Dominant -> Count + 1; true -> Count end,
            NewMin = if (NewCount * 2 > (Index + 1)) andalso ((Total - NewCount) * 2 > (length(Nums) - (Index + 1))) -> min(Min, Index); true -> Min end,
            {Index + 1, NewCount, NewMin}
        end,
        {0, 0, length(Nums)},
        Nums
    ),
    case MinIndex of
        length(Nums) -> -1;
        _ -> MinIndex
    end.

find_dominant(Nums) ->
    Counts = lists:foldl(
        fun(X, Acc) ->
            maps:update_with(X, fun(V) -> V + 1 end, 1, Acc)
        end,
        #{},
        Nums
    ),
    {Dominant, _} = maps:fold(
        fun(K, V, {CurrentDom, CurrentMax}) ->
            if V > CurrentMax -> {K, V}; true -> {CurrentDom, CurrentMax} end
        end,
        {0, 0},
        Counts
    ),
    Dominant.

count_occurrences(Nums, Dominant) ->
    lists:foldl(
        fun(X, Acc) ->
            if X == Dominant -> Acc + 1; true -> Acc end
        end,
        0,
        Nums
    ).