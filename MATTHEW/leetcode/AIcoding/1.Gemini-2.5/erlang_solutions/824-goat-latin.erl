-module(solution).
-export([to_goat_latin/1]).

-spec to_goat_latin(Sentence :: unicode:unicode_binary()) -> unicode:unicode_binary().
to_goat_latin(Sentence) ->
    Words = string:tokens(unicode:characters_to_list(Sentence), " "),
    TransformedWords = transform_words(Words, 1, []),
    unicode:characters_to_binary(string:join(TransformedWords, " ")).

transform_words([], _Index, Acc) -> lists:reverse(Acc);
transform_words([Word | Rest], Index, Acc) ->
    TransformedWord = transform_single_word(Word, Index),
    transform_words(Rest, Index + 1, [TransformedWord | Acc]).

transform_single_word(Word, Index) ->
    FirstChar = hd(Word),
    Suffix = "ma" ++ string:replicate($a, Index),
    if
        is_vowel(FirstChar) ->
            Word ++ Suffix;
        true ->
            tl(Word) ++ [FirstChar] ++ Suffix
    end.

is_vowel(Char) ->
    lists:member(erlang:to_lower(Char), [$a, $e, $i, $o, $u]).