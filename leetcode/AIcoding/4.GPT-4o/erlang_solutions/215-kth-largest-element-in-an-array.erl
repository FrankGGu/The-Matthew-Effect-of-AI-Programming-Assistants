-spec find_kth_largest(Nums :: [integer()], K :: integer()) -> integer().
find_kth_largest(Nums, K) ->
    lists:nth(K, lists:sort(fun(X, Y) -> X >= Y end, Nums)).
