-spec minimum_cost(Nums :: [integer()]) -> integer().
minimum_cost(Nums) ->
    [H | T] = Nums,
    SortedT = lists:sort(T),
    [Min1, Min2 | _] = SortedT,
    H + Min1 + Min2.