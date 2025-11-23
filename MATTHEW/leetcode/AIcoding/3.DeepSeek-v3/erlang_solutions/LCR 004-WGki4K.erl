-spec single_number(Nums :: [integer()]) -> integer().
single_number(Nums) ->
    lists:foldl(
        fun(X, {Ones, Twos}) ->
            Ones1 = (Ones bxor X) band (bnot Twos),
            Twos1 = (Twos bxor X) band (bnot Ones1),
            {Ones1, Twos1}
        end,
        {0, 0},
        Nums
    ),
    element(1, lists:foldl(
        fun(X, {Ones, Twos}) ->
            Ones1 = (Ones bxor X) band (bnot Twos),
            Twos1 = (Twos bxor X) band (bnot Ones1),
            {Ones1, Twos1}
        end,
        {0, 0},
        Nums
    )).