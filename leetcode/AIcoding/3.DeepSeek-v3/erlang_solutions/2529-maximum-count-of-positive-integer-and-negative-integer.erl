-spec maximum_count(Nums :: [integer()]) -> integer().
maximum_count(Nums) ->
    {Neg, Pos} = lists:partition(fun(X) -> X < 0 end, Nums),
    max(length(Neg), length(Pos)).