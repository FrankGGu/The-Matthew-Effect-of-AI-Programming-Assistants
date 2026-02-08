-module(solution).
-export([can_be_typed_words/2]).

-include_lib("stdlib/include/sets.hrl").

can_be_typed_words(Text, BrokenLetters) ->
    Words = string:tokens(Text, " "),
    BrokenLettersSet = sets:from_list(BrokenLetters),

    lists:foldl(fun(Word, Acc) ->
                    if can_type_word(Word, BrokenLettersSet) ->
                           Acc + 1;
                       true ->
                           Acc
                    end
                end, 0, Words).

can_type_word(Word, BrokenLettersSet) ->
    lists:all(fun(Char) -> not sets:is_element(Char, BrokenLettersSet) end, Word).