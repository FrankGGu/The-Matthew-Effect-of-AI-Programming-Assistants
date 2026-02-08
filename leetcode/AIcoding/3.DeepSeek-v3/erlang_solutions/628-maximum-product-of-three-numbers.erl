-spec maximum_product([integer()]) -> integer().
maximum_product(Nums) ->
    Sorted = lists:sort(Nums),
    Len = length(Sorted),
    Product1 = lists:nth(Len, Sorted) * lists:nth(Len - 1, Sorted) * lists:nth(Len - 2, Sorted),
    Product2 = lists:nth(1, Sorted) * lists:nth(2, Sorted) * lists:nth(Len, Sorted),
    max(Product1, Product2).