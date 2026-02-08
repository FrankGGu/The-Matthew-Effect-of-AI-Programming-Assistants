-spec min_operations(Nums :: [integer()], K :: integer()) -> integer().
min_operations(Nums, K) ->
    Sorted = lists:sort(Nums),
    count_operations(Sorted, K, 0).

count_operations([H | T], K, Count) when H < K ->
    count_operations(T, K, Count + 1);
count_operations(_, _, Count) ->
    Count.