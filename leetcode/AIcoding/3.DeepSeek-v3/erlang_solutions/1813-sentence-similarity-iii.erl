-smodule(sentence_similarity).
-export([are_sentences_similar/2]).

are_sentences_similar(Sentence1, Sentence2) ->
    Words1 = string:tokens(Sentence1, " "),
    Words2 = string:tokens(Sentence2, " "),
    are_similar(Words1, Words2).

are_similar(Words1, Words2) when length(Words1) > length(Words2) ->
    are_similar(Words2, Words1);
are_similar(Words1, Words2) ->
    N1 = length(Words1),
    N2 = length(Words2),
    I = 0,
    {Prefix, I1} = count_prefix(Words1, Words2, I),
    {Suffix, I2} = count_suffix(Words1, Words2, N1, N2, N1),
    Prefix + Suffix >= N1.

count_prefix([], _, Acc) -> {Acc, Acc};
count_prefix(_, [], Acc) -> {Acc, Acc};
count_prefix([H1|T1], [H2|T2], Acc) ->
    case H1 =:= H2 of
        true -> count_prefix(T1, T2, Acc + 1);
        false -> {Acc, Acc}
    end.

count_suffix(_, _, _, _, 0) -> {0, 0};
count_suffix(Words1, Words2, N1, N2, I) ->
    case lists:nth(N1 - I + 1, Words1) =:= lists:nth(N2 - I + 1, Words2) of
        true -> 
            {Suffix, _} = count_suffix(Words1, Words2, N1, N2, I - 1),
            {Suffix + 1, I - 1};
        false -> {0, I}
    end.