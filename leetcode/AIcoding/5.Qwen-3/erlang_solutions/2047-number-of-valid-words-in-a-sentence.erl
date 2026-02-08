-module(solution).
-export([count_valid_words/1]).

count_valid_words(Sentence) ->
    Words = string:split(Sentence, " ", all),
    lists:foldl(fun(Word, Acc) -> 
        case is_valid_word(Word) of
            true -> Acc + 1;
            false -> Acc
        end
    end, 0, Words).

is_valid_word(Word) ->
    Length = length(Word),
    if
        Length < 2 -> false;
        true ->
            case lists:member($-, Word) of
                true ->
                    case lists:member($-, lists:tl(Word)) of
                        true -> false;
                        false ->
                            case lists:member($-, lists:droplast(Word)) of
                                true -> false;
                                false ->
                                    count_hyphens(Word) == 1 andalso has_only_letters_or_hyphen(Word)
                            end
                    end;
                false ->
                    has_only_letters_or_hyphen(Word)
            end
    end.

count_hyphens(Word) ->
    lists:foldl(fun(C, Acc) -> if C == $- -> Acc + 1; true -> Acc end end, 0, Word).

has_only_letters_or_hyphen(Word) ->
    lists:all(fun(C) -> (C >= $a andalso C =< $z) orelse C == $- end, Word).