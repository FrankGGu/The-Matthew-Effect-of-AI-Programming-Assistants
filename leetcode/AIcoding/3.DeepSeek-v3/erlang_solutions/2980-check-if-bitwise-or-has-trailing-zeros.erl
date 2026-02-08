-spec has_trailing_zeros(Nums :: [integer()]) -> boolean().
has_trailing_zeros(Nums) ->
    lists:any(fun(X) -> (X band 1) =:= 0 end, Nums).