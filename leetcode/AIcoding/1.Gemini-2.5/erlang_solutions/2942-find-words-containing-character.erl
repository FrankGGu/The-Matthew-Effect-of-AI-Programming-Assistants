-module(solution).
-export([findWordsContainingCharacter/2]).

findWordsContainingCharacter(Words, Char) ->
    find_words_containing_char_helper(Words, Char, 0, []).

find_words_containing_char_helper([], _Char, _Index, Acc) ->
    lists:reverse(Acc);
find_words_containing_char_helper([Word | Rest], Char, Index, Acc) ->
    case lists:member(Char, Word) of
        true ->
            find_words_containing_char_helper(Rest, Char, Index + 1, [Index | Acc]);
        false ->
            find_words_containing_char_helper(Rest, Char, Index + 1, Acc)
    end.