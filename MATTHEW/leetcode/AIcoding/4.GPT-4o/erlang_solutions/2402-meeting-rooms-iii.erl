-module(meeting_rooms_iii).
-export([min_meeting_rooms/1]).

min_meeting_rooms(Intervals) ->
    IntervalsSorted = lists:sort(fun({Start1, _}, {Start2, _}) -> Start1 < Start2 end, Intervals),
    min_rooms(IntervalsSorted, []).

min_rooms([], Rooms) -> length(Rooms);
min_rooms([{Start, End} | Rest], Rooms) ->
    Rooms1 = lists:filter(fun(R) -> R > Start end, Rooms),
    Rooms2 = lists:sort(fun(A, B) -> A < B end, [End | Rooms1]),
    min_rooms(Rest, Rooms2).