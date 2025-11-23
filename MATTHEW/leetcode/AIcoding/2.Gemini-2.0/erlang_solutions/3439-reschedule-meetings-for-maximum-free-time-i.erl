-module(reschedule_meetings).
-export([max_free_time/1]).

max_free_time(Meetings) ->
    SortedMeetings = lists:sort(Meetings),
    max_free_time_helper(SortedMeetings, 0, 0).

max_free_time_helper([], MaxFreeTime, _) ->
    MaxFreeTime;
max_free_time_helper([[[Start, End]|Rest]|MeetingsTail], MaxFreeTime, LastEndTime) ->
    case LastEndTime < Start of
        true ->
            NewMaxFreeTime = max(MaxFreeTime, Start - LastEndTime);
            max_free_time_helper([MeetingsTail], NewMaxFreeTime, End);
        false ->
            NewLastEndTime = max(LastEndTime, End);
            max_free_time_helper([MeetingsTail], MaxFreeTime, NewLastEndTime)
    end;
max_free_time_helper([[]|MeetingsTail], MaxFreeTime, LastEndTime) ->
    max_free_time_helper(MeetingsTail, MaxFreeTime, LastEndTime);
max_free_time_helper([[[Start, End]|Rest]|MeetingsTail], MaxFreeTime, 0) ->
    max_free_time_helper([MeetingsTail], MaxFreeTime, End).