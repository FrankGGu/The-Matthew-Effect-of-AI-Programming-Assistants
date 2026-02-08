-module(solution).
-export([min_number_of_chairs/2]).

min_number_of_chairs(StartTimes, EndTimes) ->
    Events = lists:flatmap(fun({Start, End}) -> [{Start, 1}, {End, -1}] end, lists:zip(StartTimes, EndTimes)),
    SortedEvents = lists:sort(fun({Time1, _}, {Time2, _}) -> Time1 < Time2 end, Events),
    min_chairs(SortedEvents, 0, 0).

min_chairs([], Current, Max) -> Max;
min_chairs([{_, Change} | Rest], Current, Max) ->
    NewCurrent = Current + Change,
    min_chairs(Rest, NewCurrent, max(Max, NewCurrent)).