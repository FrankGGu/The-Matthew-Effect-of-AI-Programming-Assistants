-module(solution).
-export([merge/1]).

merge([]) -> [];
merge(Intervals) ->
    SortedIntervals = lists:sort(Intervals),
    case SortedIntervals of
        [] -> [];
        [H | T] ->
            lists:reverse(lists:foldl(fun merge_interval/2, [H], T))
    end.

merge_interval([NextStart, NextEnd], Acc = [[CurrentStart, CurrentEnd] | _AccTail]) ->
    if
        NextStart =< CurrentEnd ->
            NewCurrentEnd = max(CurrentEnd, NextEnd),
            [[CurrentStart, NewCurrentEnd] | tl(Acc)];
        true ->
            [[NextStart, NextEnd] | Acc]
    end.