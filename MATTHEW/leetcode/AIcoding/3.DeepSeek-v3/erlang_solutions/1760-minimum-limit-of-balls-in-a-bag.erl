-spec max_operations(Nums :: [integer()], K :: integer()) -> integer().
max_operations(Nums, K) ->
    Sorted = lists:sort(Nums),
    max_operations(Sorted, K, 0, length(Nums) - 1, 0).

max_operations(_, _, Left, Right, Count) when Left >= Right ->
    Count;
max_operations(Nums, K, Left, Right, Count) ->
    case lists:nth(Left + 1, Nums) + lists:nth(Right + 1, Nums) of
        Sum when Sum == K ->
            max_operations(Nums, K, Left + 1, Right - 1, Count + 1);
        Sum when Sum < K ->
            max_operations(Nums, K, Left + 1, Right, Count);
        _ ->
            max_operations(Nums, K, Left, Right - 1, Count)
    end.