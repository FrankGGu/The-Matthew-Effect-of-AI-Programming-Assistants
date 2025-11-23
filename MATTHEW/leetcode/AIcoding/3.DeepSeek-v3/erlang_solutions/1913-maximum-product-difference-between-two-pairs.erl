-spec max_product_difference(Nums :: [integer()]) -> integer().
max_product_difference(Nums) ->
    Sorted = lists:sort(Nums),
    Len = length(Sorted),
    (lists:nth(Len, Sorted) * lists:nth(Len - 1, Sorted)) - (lists:nth(1, Sorted) * lists:nth(2, Sorted)).