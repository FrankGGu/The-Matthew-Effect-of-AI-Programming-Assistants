-module(solution).
-export([count_alternating_subarrays/1]).

count_alternating_subarrays([]) -> 0;
count_alternating_subarrays([H|T]) ->
    count_alternating_subarrays_acc(T, H, 1, 1).

count_alternating_subarrays_acc([], _PrevElement, _CurrentLength, TotalCount) ->
    TotalCount;
count_alternating_subarrays_acc([H|T], H, _CurrentLength, TotalCount) ->
    NewCurrentLength = 1,
    NewTotalCount = TotalCount + NewCurrentLength,
    count_alternating_subarrays_acc(T, H, NewCurrentLength, NewTotalCount);
count_alternating_subarrays_acc([H|T], PrevElement, CurrentLength, TotalCount) ->
    NewCurrentLength = CurrentLength + 1,
    NewTotalCount = TotalCount + NewCurrentLength,
    count_alternating_subarrays_acc(T, H, NewCurrentLength, NewTotalCount).