-spec min_cost_split_array(Nums :: [integer()]) -> integer().
min_cost_split_array(Nums) ->
    [First | Rest] = lists:sort(Nums),
    lists:sum([First | lists:sublist(Rest, 2)]).