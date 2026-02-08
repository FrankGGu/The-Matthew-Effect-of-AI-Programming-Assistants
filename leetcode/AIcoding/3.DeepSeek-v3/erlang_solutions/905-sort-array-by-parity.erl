-spec sort_array_by_parity(Nums :: [integer()]) -> [integer()].
sort_array_by_parity(Nums) ->
    Even = [X || X <- Nums, X rem 2 == 0],
    Odd = [X || X <- Nums, X rem 2 =/= 0],
    Even ++ Odd.