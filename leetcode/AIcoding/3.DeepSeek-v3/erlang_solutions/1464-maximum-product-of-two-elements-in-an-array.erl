-spec max_product(Nums :: [integer()]) -> integer().
max_product(Nums) ->
    Sorted = lists:sort(fun(A, B) -> A > B end, Nums),
    (lists:nth(1, Sorted) - 1) * (lists:nth(2, Sorted) - 1).