-module(segments).
-export([countSegments/1]).

countSegments(S) ->
    count_words(string:tokens(S, " ")).

count_words([]) ->
    0;
count_words(Words) ->
    lists:foldl(fun(Word, Acc) ->
                        case string:len(Word) > 0 of
                            true -> Acc + 1;
                            false -> Acc
                        end
                end, 0, Words).