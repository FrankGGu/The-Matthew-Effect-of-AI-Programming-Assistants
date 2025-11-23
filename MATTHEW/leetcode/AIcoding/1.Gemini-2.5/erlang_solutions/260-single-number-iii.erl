-spec single_number(Nums :: [integer()]) -> [integer()].
single_number(Nums) ->
    XorSum = lists:foldl(fun(N, Acc) -> N bxor Acc end, 0, Nums),

    % Find the rightmost set bit in XorSum.
    % This bit will be different for the two unique numbers.
    % In Erlang, X band (bnot (X - 1)) works for positive X.
    % For arbitrary integers, X band (bnot X + 1) is equivalent to X & (-X)
    % which finds the lowest set bit.
    Mask = XorSum band (bnot XorSum + 1),

    {Num1, Num2} = lists:foldl(
        fun(N, {Acc1, Acc2}) ->
            if
                (N band Mask) =/= 0 ->
                    {N bxor Acc1, Acc2};
                true ->
                    {Acc1, N bxor Acc2}
            end
        end,
        {0, 0},
        Nums
    ),
    [Num1, Num2].