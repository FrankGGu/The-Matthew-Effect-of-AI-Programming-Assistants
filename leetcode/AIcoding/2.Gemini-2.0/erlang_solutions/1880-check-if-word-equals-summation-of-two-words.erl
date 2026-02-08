-module(check_if_word_equals_summation).
-export([is_sum_equal/3]).

is_sum_equal(FirstWord, SecondWord, TargetWord) ->
    Value1 = word_value(FirstWord),
    Value2 = word_value(SecondWord),
    Value3 = word_value(TargetWord),
    Value1 + Value2 =:= Value3.

word_value(Word) ->
    word_value(Word, 0).

word_value([], Acc) ->
    Acc;
word_value([Char | Rest], Acc) ->
    Value = Char - $a,
    word_value(Rest, Acc * 10 + Value).