-module(solution).
-export([chalkReplacer/2]).

chalkReplacer(Chalk, K) ->
    TotalChalkInCycle = lists:sum(Chalk),
    RemainingK = K rem TotalChalkInCycle,
    find_replacer(Chalk, RemainingK, 0).

find_replacer([H | T], CurrentK, Index) ->
    if CurrentK < H ->
        Index;
    true ->
        find_replacer(T, CurrentK - H, Index + 1)
    end.