-module(solution).
-export([is_sum_equal/2]).

is_sum_equal(Word1, Word2) ->
    Sum = word_to_number(Word1) + word_to_number(Word2),
    Sum == word_to_number(Word3).

word_to_number(Word) ->
    lists:foldl(fun(Char, Acc) -> Acc * 10 + (Char - $a + 1) end, 0, Word).