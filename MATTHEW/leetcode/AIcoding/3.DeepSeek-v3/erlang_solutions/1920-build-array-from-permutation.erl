-spec build_array(Nums :: [integer()]) -> [integer()].
build_array(Nums) ->
    [lists:nth(X + 1, Nums) || X <- Nums].