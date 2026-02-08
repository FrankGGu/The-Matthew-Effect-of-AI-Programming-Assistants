-spec is_pangram(Sentence :: unicode:unicode_binary()) -> boolean().
is_pangram(Sentence) ->
    LowerSentence = string:lowercase(Sentence),
    AllLetters = lists:seq($a, $z),
    lists:all(fun(Char) -> lists:member(Char, LowerSentence) end, AllLetters).