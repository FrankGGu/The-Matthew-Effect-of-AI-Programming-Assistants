-spec minimum_operations(Nums :: [integer()]) -> integer().
minimum_operations(Nums) ->
    Sorted = lists:sort(Nums),
    Unique = lists:usort(Sorted),
    NonZero = [X || X <- Unique, X =/= 0],
    length(NonZero).