-spec minimum_operations(Nums :: [integer()]) -> integer().
minimum_operations(Nums) ->
    PositiveNums = lists:filter(fun(N) -> N > 0 end, Nums),
    UniquePositiveNums = lists:usort(PositiveNums),
    length(UniquePositiveNums).