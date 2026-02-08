-module(solution).
-export([canBeTypedWords/2]).

canBeTypedWords(Text, BrokenLetters) ->
    BrokenLettersSet = sets:from_list(BrokenLetters),
    Words = string:tokens(Text, " "),
    lists:foldl(
        fun(Word, Acc) ->
            if
                can_type_word(Word, BrokenLettersSet) -> Acc + 1;
                true -> Acc
            end
        end,
        0,
        Words
    ).

can_type_word(Word, BrokenLettersSet) ->
    lists:all(fun(Char) -> not sets:is_element(Char, BrokenLettersSet) end, Word).