-module(solution).
-export([is_sum_equal/3]).

is_sum_equal(FirstWord, SecondWord, TargetWord) ->
    Val1 = word_to_int(FirstWord),
    Val2 = word_to_int(SecondWord),
    Val3 = word_to_int(TargetWord),
    Val1 + Val2 == Val3.

word_to_int(Word) ->
    lists:foldl(fun(Char, Acc) ->
                        Acc * 10 + (Char - $a)
                end, 0, Word).