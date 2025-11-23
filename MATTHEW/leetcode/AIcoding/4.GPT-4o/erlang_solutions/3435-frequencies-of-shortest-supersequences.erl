-module(solution).
-export([shortest_supersequence/2]).

shortest_supersequence(S, T) ->
    SList = string:tokens(S, ""),
    TList = string:tokens(T, ""),
    LengthS = length(SList),
    LengthT = length(TList),
    SuperSeq = shortest_super_seq(SList, TList, LengthS, LengthT),
    count_frequencies(SList, SuperSeq).

shortest_super_seq(_, [], _, _) -> [];
shortest_super_seq([], _, _, _) -> [];
shortest_super_seq(SList, TList, LengthS, LengthT) ->
    case lists:member(hd(TList), SList) of
        true -> [hd(TList) | shortest_super_seq(SList, tl(TList), LengthS, LengthT)];
        false -> shortest_super_seq(SList, tl(TList), LengthS, LengthT)
    end.

count_frequencies(SList, SuperSeq) ->
    lists:foldl(fun(X, Acc) -> 
        case lists:member(X, SuperSeq) of
            true -> Acc + 1;
            false -> Acc
        end
    end, 0, SList).