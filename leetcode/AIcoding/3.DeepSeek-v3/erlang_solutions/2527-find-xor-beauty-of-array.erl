-spec xor_beauty(Nums :: [integer()]) -> integer().
xor_beauty(Nums) ->
    lists:foldl(fun(X, Acc) -> X bxor Acc end, 0, Nums).