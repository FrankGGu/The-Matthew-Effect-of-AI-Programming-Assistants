-spec max_kelements(Nums :: [integer()], K :: integer()) -> integer().
max_kelements(Nums, K) ->
    Sorted = lists:sort(fun(A, B) -> A > B end, Nums),
    Selected = lists:sublist(Sorted, K),
    lists:sum(Selected).