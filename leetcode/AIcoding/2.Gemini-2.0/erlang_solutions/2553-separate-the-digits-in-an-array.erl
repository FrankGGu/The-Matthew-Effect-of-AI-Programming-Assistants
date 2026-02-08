-module(separate_digits).
-export([separate_digits/1]).

separate_digits(Nums) ->
    lists:flatten([separate(Num) || Num <- Nums]).

separate(Num) ->
    separate_helper(Num, []).

separate_helper(0, Acc) ->
    lists:reverse(Acc);
separate_helper(Num, Acc) ->
    Digit = Num rem 10,
    Remaining = Num div 10,
    separate_helper(Remaining, [Digit | Acc]).