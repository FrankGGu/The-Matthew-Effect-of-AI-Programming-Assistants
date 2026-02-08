-spec xor_game(Nums :: [integer()]) -> boolean().
xor_game(Nums) ->
    case lists:foldl(fun(X, Acc) -> X bxor Acc end, 0, Nums) of
        0 -> true;
        _ -> length(Nums) rem 2 == 0
    end.