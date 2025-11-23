-module(sentence_similarity_iii).
-export([are_sentences_similar/2]).

are_sentences_similar(Sentence1, Sentence2) ->
    Words1 = string:split(Sentence1, " "),
    Words2 = string:split(Sentence2, " "),
    case length(Words1) of
        Length when Length == length(Words2) ->
            check_same(Words1, Words2);
        _ ->
            false
    end.

check_same([], []) ->
    true;
check_same([H1|T1], [H2|T2]) ->
    if
        H1 == H2 ->
            check_same(T1, T2);
        true ->
            check_prefix(Words1, Words2)
    end.

check_prefix([], _) ->
    true;
check_prefix(_, []) ->
    true;
check_prefix([H1|T1], [H2|T2]) ->
    if
        H1 == H2 ->
            check_prefix(T1, T2);
        true ->
            false
    end.