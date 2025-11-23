-module(solution).
-export([max_free_time/2]).

max_free_time(Meetings1, Meetings2) ->
    Meetings = lists:append(Meetings1, Meetings2),
    SortedMeetings = lists:sort(fun({Start1, _}, {Start2, _}) -> Start1 < Start2 end, Meetings),
    MaxFreeTime(SortedMeetings, 0).

MaxFreeTime([], PrevEnd) -> PrevEnd;
MaxFreeTime([{Start, End} | T], PrevEnd) ->
    NewPrevEnd = max(PrevEnd, End),
    MaxFreeTime(T, NewPrevEnd).