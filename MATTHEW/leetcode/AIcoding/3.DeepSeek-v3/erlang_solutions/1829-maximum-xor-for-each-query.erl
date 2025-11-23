-spec get_maximum_xor(Nums :: [integer()], MaximumBit :: integer()) -> [integer()].
get_maximum_xor(Nums, MaximumBit) ->
    MaxNum = (1 bsl MaximumBit) - 1,
    lists:foldr(fun(X, Acc) -> [X bxor MaxNum | Acc] end, [], lists:foldl(fun(X, Acc) -> [X bxor lists:nth(1, Acc) | Acc] end, [0], Nums)).