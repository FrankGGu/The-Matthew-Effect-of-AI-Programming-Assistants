-module(solution).
-export([is_sum_equal/3]).

is_sum_equal(W1, W2, W3) ->
    Num1 = word_to_number(W1),
    Num2 = word_to_number(W2),
    Sum = Num1 + Num2,
    Sum =:= word_to_number(W3).

word_to_number(Word) ->
    lists:foldl(fun(Char, Acc) ->
        Acc * 10 + (char_to_integer(Char) - 97)
    end, 0, Word).