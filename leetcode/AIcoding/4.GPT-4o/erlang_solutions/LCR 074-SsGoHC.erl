-module(solution).
-export([merge/1]).

merge(Intervals) ->
    SortedIntervals = lists:sort(fun({Start1, _}, {Start2, _}) -> Start1 < Start2 end, Intervals),
    merge_intervals(SortedIntervals, []).

merge_intervals([], Acc) -> 
    lists:reverse(Acc);
merge_intervals([H | T], Acc) ->
    merge_helper(T, H, Acc).

merge_helper([], Current, Acc) -> 
    lists:reverse([Current | Acc]);
merge_helper([{Start, End} | T], {CurStart, CurEnd} = Current, Acc) when Start =< CurEnd ->
    NewCurrent = {CurStart, lists:max([CurEnd, End])},
    merge_helper(T, NewCurrent, Acc);
merge_helper(T, Current, Acc) ->
    merge_helper(T, hd(T), [Current | Acc]).