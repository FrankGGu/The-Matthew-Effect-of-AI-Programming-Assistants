-module(find_words).
-export([countCharacters/2]).

countCharacters(Words, Chars) ->
    countCharacters(Words, Chars, 0).

countCharacters([], _, Acc) ->
    Acc;
countCharacters([Word | Rest], Chars, Acc) ->
    case canForm(Word, Chars) of
        true ->
            countCharacters(Rest, Chars, Acc + length(Word));
        false ->
            countCharacters(Rest, Chars, Acc)
    end.

canForm(Word, Chars) ->
    canForm(Word, Chars, []).

canForm([], _, _) ->
    true;
canForm([Char | Rest], Chars, Used) ->
    case lists:member(Char, Chars -- Used) of
        true ->
            canForm(Rest, Chars, [Char | Used]);
        false ->
            false
    end.