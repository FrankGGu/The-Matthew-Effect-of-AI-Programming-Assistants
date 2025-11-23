-spec max_product(Nums :: [integer()]) -> integer().
max_product(Nums) ->
    SortedNums = lists:sort(fun(A, B) -> A >= B end, Nums),
    [A, B | _] = SortedNums,
    (A - 1) * (B - 1).