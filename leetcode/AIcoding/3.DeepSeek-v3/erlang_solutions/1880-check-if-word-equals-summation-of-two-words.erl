-spec is_sum_equal(FirstWord :: unicode:unicode_binary(), SecondWord :: unicode:unicode_binary(), TargetWord :: unicode:unicode_binary()) -> boolean().
is_sum_equal(FirstWord, SecondWord, TargetWord) ->
    Value1 = word_to_value(FirstWord),
    Value2 = word_to_value(SecondWord),
    TargetValue = word_to_value(TargetWord),
    Value1 + Value2 =:= TargetValue.

word_to_value(Word) ->
    Chars = unicode:characters_to_list(Word),
    lists:foldl(fun(Char, Acc) -> Acc * 10 + (Char - $a) end, 0, Chars).