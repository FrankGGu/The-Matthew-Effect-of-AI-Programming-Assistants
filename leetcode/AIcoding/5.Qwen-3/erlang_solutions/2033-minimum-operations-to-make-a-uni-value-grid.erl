-module(min_operations).
-export([minOperations/1]).

minOperations(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    Values = lists:foldl(fun(Row, Acc) ->
        lists:foldl(fun(Val, Acc2) -> [Val | Acc2] end, Acc, Row)
    end, [], Grid),
    Median = findMedian(Values),
    lists:sum(lists:map(fun(V) -> abs(V - Median) end, Values)).

findMedian(List) ->
    Sorted = lists:sort(List),
    Len = length(Sorted),
    Mid = Len div 2,
    lists:nth(Mid + 1, Sorted).