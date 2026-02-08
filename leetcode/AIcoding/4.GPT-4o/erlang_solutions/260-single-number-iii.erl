-spec single_number(Nums :: [integer()]) -> [integer()].
single_number(Nums) ->
    XorResult = lists:foldl(fun(X, Acc) -> X bxor Acc end, 0, Nums),
    Mask = XorResult band -XorResult,
    {Left, Right} = lists:foldl(
        fun(X, {LeftAcc, RightAcc}) ->
            if
                X band Mask == 0 -> {LeftAcc, RightAcc ++ [X]};
                true -> {LeftAcc ++ [X], RightAcc}
            end
        end, {[], []}, Nums),
    Left ++ Right.
