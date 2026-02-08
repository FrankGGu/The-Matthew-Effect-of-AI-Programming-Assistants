-module(solution).
-export([count_valid_words/1]).

count_valid_words(Sentence) ->
    Words = string:tokens(Sentence, " "),
    lists:foldl(fun(Word, Acc) -> Acc + is_valid_word(Word) end, 0, Words).

is_valid_word(Word) ->
    case string:len(Word) of
        0 -> false;
        _ ->
            Puncts = ".,!?",
            PunctCount = lists:foldl(fun(C, Acc) -> if lists:member(C, Puncts) -> Acc + 1; true -> Acc end end, 0, string:to_list(Word)),
            if
                PunctCount > 1 -> false;
                PunctCount == 1 -> valid_with_punct(Word);
                true -> valid_without_punct(Word)
            end
    end.

valid_with_punct(Word) ->
    LastChar = lists:last(string:to_list(Word)),
    lists:all(fun(C) -> C =/= LastChar end, string:to_list(Word)).

valid_without_punct(Word) ->
    lists:all(fun(C) -> C >= $a, C =< $z orelse C >= $A, C =< $Z orelse C == $'-' end, string:to_list(Word)).