-spec xor_game(Nums :: [integer()]) -> boolean().
xor_game(Nums) ->
    XorSum = lists:foldl(fun(N, Acc) -> N bxor Acc end, 0, Nums),
    if
        XorSum == 0 ->
            true;
        true -> % XorSum /= 0
            (length(Nums) rem 2) == 0
    end.