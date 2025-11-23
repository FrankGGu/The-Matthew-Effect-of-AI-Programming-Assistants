-module(solution).
-export([circular_sentence/1]).

circular_sentence(Sentence) ->
    Words = string:tokens(Sentence, " "),
    ListLen = length(Words),
    circular_check(Words, ListLen).

circular_check(Words, 1) -> 
    FirstWord = hd(Words),
    LastWord = lists:last(Words),
    string:at(FirstWord, 1) =:= string:at(LastWord, length(LastWord));
circular_check(Words, N) ->
    FirstWord = hd(Words),
    LastWord = lists:last(Words),
    if
        string:at(FirstWord, 1) =:= string:at(LastWord, length(LastWord)) ->
            circular_check(tl(Words) ++ [FirstWord], N - 1);
        true -> 
            false
    end.