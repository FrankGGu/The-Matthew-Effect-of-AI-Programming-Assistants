-spec smaller_numbers_than_current(Nums :: [integer()]) -> [integer()].
smaller_numbers_than_current(Nums) ->
    Sorted = lists:sort(Nums),
    Map = maps:from_list(lists:zip(Sorted, lists:seq(0, length(Sorted) - 1))),
    lists:map(fun(X) -> maps:get(X, Map) end, Nums).