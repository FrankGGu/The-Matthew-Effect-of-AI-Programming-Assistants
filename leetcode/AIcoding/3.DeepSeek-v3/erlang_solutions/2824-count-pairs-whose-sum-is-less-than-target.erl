-spec count_pairs(Nums :: [integer()], Target :: integer()) -> integer().
count_pairs(Nums, Target) ->
    Sorted = lists:sort(Nums),
    count_pairs(Sorted, Target, 0, length(Sorted) - 1, 0).

count_pairs(_, _, Left, Right, Count) when Left >= Right ->
    Count;
count_pairs(Nums, Target, Left, Right, Count) ->
    Sum = lists:nth(Left + 1, Nums) + lists:nth(Right + 1, Nums),
    if
        Sum < Target ->
            count_pairs(Nums, Target, Left + 1, Right, Count + (Right - Left));
        true ->
            count_pairs(Nums, Target, Left, Right - 1, Count)
    end.