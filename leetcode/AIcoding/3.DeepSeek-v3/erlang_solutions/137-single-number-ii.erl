-spec single_number(Nums :: [integer()]) -> integer().
single_number(Nums) ->
    single_number(Nums, 0, 0).

single_number([], Ones, Twos) ->
    Ones;
single_number([Num | Rest], Ones, Twos) ->
    NewOnes = (Ones bxor Num) band (bnot Twos),
    NewTwos = (Twos bxor Num) band (bnot NewOnes),
    single_number(Rest, NewOnes, NewTwos).