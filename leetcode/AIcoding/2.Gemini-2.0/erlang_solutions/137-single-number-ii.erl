-module(single_number_ii).
-export([single_number/1]).

single_number(Nums) ->
    single_number_helper(Nums, 0, 0).

single_number_helper([], Ones, Twos) ->
    Ones;
single_number_helper([Num | Rest], Ones, Twos) ->
    NewOnes = (Ones bxor Num) band (bnot Twos),
    NewTwos = (Twos bxor Num) band (bnot Ones),
    single_number_helper(Rest, NewOnes, NewTwos).