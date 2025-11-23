-spec max_operations(Nums :: [integer()], K :: integer()) -> integer().
max_operations(Nums, K) ->
    Sorted = lists:sort(Nums),
    count_pairs(Sorted, K, 0, 0, length(Sorted) - 1).

count_pairs(_, _, Count, Left, Right) when Left >= Right ->
    Count;
count_pairs(Sorted, K, Count, Left, Right) ->
    Sum = lists:nth(Left + 1, Sorted) + lists:nth(Right + 1, Sorted),
    if
        Sum == K ->
            count_pairs(Sorted, K, Count + 1, Left + 1, Right - 1);
        Sum < K ->
            count_pairs(Sorted, K, Count, Left + 1, Right);
        true ->
            count_pairs(Sorted, K, Count, Left, Right - 1)
    end.