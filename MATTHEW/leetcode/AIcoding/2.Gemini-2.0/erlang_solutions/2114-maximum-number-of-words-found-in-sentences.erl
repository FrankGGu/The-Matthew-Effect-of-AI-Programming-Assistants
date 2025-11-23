-module(max_words).
-export([mostWordsFound/1]).

mostWordsFound(Sentences) ->
    lists:max([count_words(Sentence) || Sentence <- Sentences]).

count_words(Sentence) ->
    count_words(Sentence, 0).

count_words([], Acc) ->
    Acc;
count_words([H|T], Acc) ->
    case H of
        $\s ->
            count_words(T, Acc + 1);
        _ ->
            count_words(T, Acc)
    end.