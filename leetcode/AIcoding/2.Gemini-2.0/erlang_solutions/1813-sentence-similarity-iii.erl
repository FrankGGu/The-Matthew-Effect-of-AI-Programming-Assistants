-module(sentence_similarity_iii).
-export([areSentencesSimilar/2]).

areSentencesSimilar(Sentence1, Sentence2) ->
    S1 = string:split(Sentence1, " ", all),
    S2 = string:split(Sentence2, " ", all),
    areSentencesSimilarHelper(S1, S2).

areSentencesSimilarHelper(S1, S2) ->
    L1 = length(S1),
    L2 = length(S2),
    case L1 < L2 of
        true ->
            areSentencesSimilarHelper(S2, S1);
        false ->
            Front = findFront(S1, S2),
            Back = findBack(S1, S2, Front),
            Front + Back =:= length(S2)
    end.

findFront(S1, S2) ->
    findFrontHelper(S1, S2, 0).

findFrontHelper(S1, S2, Acc) ->
    case {length(S1) > Acc, length(S2) > Acc, lists:nth(Acc + 1, S1) =:= lists:nth(Acc + 1, S2)} of
        {true, true, true} ->
            findFrontHelper(S1, S2, Acc + 1);
        _ ->
            Acc
    end.

findBack(S1, S2, Front) ->
    findBackHelper(S1, S2, Front, 0).

findBackHelper(S1, S2, Front, Acc) ->
    Pos1 = length(S1) - Acc,
    Pos2 = length(S2) - Acc,
    case {Pos1 > Front, Pos2 > Front, lists:nth(Pos1, S1) =:= lists:nth(Pos2, S2)} of
        {true, true, true} ->
            findBackHelper(S1, S2, Front, Acc + 1);
        _ ->
            Acc
    end.