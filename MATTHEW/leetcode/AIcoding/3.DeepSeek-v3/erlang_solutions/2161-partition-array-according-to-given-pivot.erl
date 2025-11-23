-spec partition_array(Nums :: [integer()], Pivot :: integer()) -> [integer()].
partition_array(Nums, Pivot) ->
    Less = [X || X <- Nums, X < Pivot],
    Equal = [X || X <- Nums, X =:= Pivot],
    Greater = [X || X <- Nums, X > Pivot],
    Less ++ Equal ++ Greater.