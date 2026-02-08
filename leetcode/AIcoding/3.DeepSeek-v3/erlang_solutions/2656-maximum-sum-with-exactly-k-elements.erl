-spec max_sum(Nums :: [integer()], K :: integer()) -> integer().
max_sum(Nums, K) ->
    Sorted = lists:sort(fun(A, B) -> A >= B end, Nums),
    Sum = lists:sum(lists:sublist(Sorted, K)),
    Sum + (K * (K - 1)) div 2.