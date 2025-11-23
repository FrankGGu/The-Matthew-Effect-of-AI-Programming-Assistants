-module(longest_push_time).
-export([longest_push_time/2]).

longest_push_time(releaseTimes, pressedKeys) ->
    longest_push_time(releaseTimes, pressedKeys, 0, 0, 0, 0).

longest_push_time([], [], _, LongestDuration, LongestChar, _) ->
    list_to_atom([LongestChar + $a - 1]);
longest_push_time([RT | RestReleaseTimes], [PK | RestPressedKeys], PrevTime, LongestDuration, LongestChar, _) ->
    Duration = RT - PrevTime,
    NewLongestDuration =
        if Duration > LongestDuration then
            Duration
        else
            LongestDuration
        end,
    NewLongestChar =
        if Duration > LongestDuration then
            PK
        else
            if Duration == LongestDuration and PK > LongestChar then
                PK
            else
                LongestChar
            end
        end,
    longest_push_time(RestReleaseTimes, RestPressedKeys, RT, NewLongestDuration, NewLongestChar, _).