-spec sorted_squares(Nums :: [integer()]) -> [integer()].
sorted_squares(Nums) ->
    Squared = lists:map(fun(X) -> X * X end, Nums),
    lists:sort(Squared).