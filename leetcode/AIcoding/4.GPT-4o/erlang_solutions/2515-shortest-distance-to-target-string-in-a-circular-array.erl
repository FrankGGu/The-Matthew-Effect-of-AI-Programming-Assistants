-module(solution).
-export([shortest_distance/2]).

shortest_distance(Target, Words) ->
    WordsList = string:tokens(Words, " "),
    TargetIndexList = [Index || {Index, Word} <- lists:zip(lists:seq(0, length(WordsList) - 1), WordsList), Word =:= Target],
    case TargetIndexList of
        [] -> -1;
        _ -> 
            MinDistance(TargetIndexList, length(WordsList))
    end.

MinDistance(TargetIndexList, N) ->
    TargetIndexListLength = length(TargetIndexList),
    Distances = [min_distance(Index, TargetIndexList, N) || Index <- TargetIndexList],
    lists:min(Distances).

min_distance(Index, TargetIndexList, N) ->
    lists:min([abs(Index - Target) rem N || Target <- TargetIndexList]).