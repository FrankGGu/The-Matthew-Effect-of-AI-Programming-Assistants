-spec sort_array_by_parity(A :: [integer()]) -> [integer()].
sort_array_by_parity(A) ->
    Even = [X || X <- A, X rem 2 == 0],
    Odd = [X || X <- A, X rem 2 =/= 0],
    Even ++ Odd.