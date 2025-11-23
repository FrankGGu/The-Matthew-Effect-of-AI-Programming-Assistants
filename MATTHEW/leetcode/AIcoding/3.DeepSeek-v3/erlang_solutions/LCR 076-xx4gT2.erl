-spec find_kth_largest(Nums :: [integer()], K :: integer()) -> integer().
find_kth_largest(Nums, K) ->
    Sorted = lists:sort(fun(A, B) -> A >= B end, Nums),
    lists:nth(K, Sorted).