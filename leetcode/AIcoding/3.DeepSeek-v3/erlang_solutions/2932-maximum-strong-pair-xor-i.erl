-spec maximum_strong_pair_xor(Nums :: [integer()]) -> integer().
maximum_strong_pair_xor(Nums) ->
    lists:max([X bxor Y || X <- Nums, Y <- Nums, abs(X - Y) =< min(X, Y)]).