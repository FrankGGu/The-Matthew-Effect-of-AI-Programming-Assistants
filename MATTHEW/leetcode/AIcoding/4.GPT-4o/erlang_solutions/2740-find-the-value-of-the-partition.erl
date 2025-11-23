-module(solution).
-export([find_value_partition/1]).

find_value_partition(List) ->
    SortedList = lists:sort(List),
    Length = length(SortedList),
    If Length rem 2 == 1 -> 
        lists:nth(Length div 2 + 1, SortedList);
    If Length rem 2 == 0 ->
        (lists:nth(Length div 2, SortedList) + lists:nth(Length div 2 + 1, SortedList)) div 2
    end.