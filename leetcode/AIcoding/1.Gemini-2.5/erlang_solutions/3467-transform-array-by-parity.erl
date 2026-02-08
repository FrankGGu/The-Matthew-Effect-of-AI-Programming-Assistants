-spec sort_array_by_parity(Nums :: [integer()]) -> [integer()].
sort_array_by_parity(Nums) ->
    {Evens, Odds} = lists:partition(fun(N) -> N rem 2 == 0 end, Nums),
    Evens ++ Odds.