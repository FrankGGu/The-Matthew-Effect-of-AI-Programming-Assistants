-spec minimum_operations(Nums :: [integer()]) -> integer().
minimum_operations(Nums) ->
    PositiveNums = lists:filter(fun(X) -> X > 0 end, Nums),
    UniquePositiveNums = sets:from_list(PositiveNums),
    sets:size(UniquePositiveNums).