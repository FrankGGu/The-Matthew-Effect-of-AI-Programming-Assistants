-module(solution).
-export([maximumGap/1]).

maximumGap(Nums) ->
    case length(Nums) of
        Len when Len < 2 -> 0;
        _ ->
            SortedNums = lists:sort(Nums),
            find_max_gap(tl(SortedNums), hd(SortedNums), 0)
    end.

find_max_gap([], _Prev, MaxGap) ->
    MaxGap;
find_max_gap([Current | Rest], Prev, MaxGap) ->
    Diff = Current - Prev,
    NewMaxGap = max(MaxGap, Diff),
    find_max_gap(Rest, Current, NewMaxGap).