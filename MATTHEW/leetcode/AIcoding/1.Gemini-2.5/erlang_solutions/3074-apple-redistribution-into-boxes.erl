-module(solution).
-export([redistribute_apples/2]).

redistribute_apples(Apple, Capacity) ->
    TotalApples = lists:sum(Apple),
    SortedCapacity = lists:reverse(lists:sort(Capacity)),
    count_boxes(TotalApples, SortedCapacity, 0, 0).

count_boxes(TargetApples, [H|T], Count, CurrentSum) ->
    NewSum = CurrentSum + H,
    NewCount = Count + 1,
    if
        NewSum >= TargetApples ->
            NewCount;
        true ->
            count_boxes(TargetApples, T, NewCount, NewSum)
    end;
count_boxes(_TargetApples, [], Count, _CurrentSum) ->
    Count.