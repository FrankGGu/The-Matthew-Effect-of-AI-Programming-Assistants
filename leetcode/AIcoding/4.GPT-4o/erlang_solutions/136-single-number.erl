-spec single_number(Nums :: [integer()]) -> integer().
single_number(Nums) ->
    lists:foldl(fun(X, Acc) -> X bxor Acc end, 0, Nums).
