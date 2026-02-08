-module(solution).
-export([are_sentences_similar/2]).

are_sentences_similar(S1, S2) ->
    Words1 = string:tokens(S1, " "),
    Words2 = string:tokens(S2, " "),
    check_similarity(Words1, Words2).

check_similarity(Words1, Words2) ->
    case {length(Words1), length(Words2)} of
        {N1, N2} when N1 == N2 -> 
            Words1 =:= Words2;
        {N1, N2} when N1 > N2 -> 
            check_with_prefix(Words1, Words2);
        {N1, N2} -> 
            check_with_prefix(Words2, Words1)
    end.

check_with_prefix(Longer, Shorter) ->
    Prefix = lists:prefix(Longer, Shorter),
    Suffix = lists:reverse(lists:prefix(lists:reverse(Longer), lists:length(Longer) - lists:length(Shorter))),
    Prefix andalso lists:reverse(Suffix) =:= Shorter.