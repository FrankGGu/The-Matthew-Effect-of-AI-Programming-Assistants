-module(solution).
-export([numberOfRounds/2]).

numberOfRounds(StartTime, EndTime) ->
    [StartHStr, StartMStr] = string:split(StartTime, ":", all),
    StartH = list_to_integer(StartHStr),
    StartM = list_to_integer(StartMStr),
    StartTimeMinutes = StartH * 60 + StartM,

    [EndHStr, EndMStr] = string:split(EndTime, ":", all),
    EndH = list_to_integer(EndHStr),
    EndM = list_to_integer(EndMStr),
    EndTimeMinutes = EndH * 60 + EndM,

    AdjustedEndTimeMinutes = if
                                 EndTimeMinutes < StartTimeMinutes ->
                                     EndTimeMinutes + 24 * 60;
                                 true ->
                                     EndTimeMinutes
                             end,

    StartRoundMinutes = (StartTimeMinutes + 14) div 15 * 15,
    EndRoundMinutes = AdjustedEndTimeMinutes - (AdjustedEndTimeMinutes rem 15),

    if
        StartRoundMinutes >= EndRoundMinutes ->
            0;
        true ->
            (EndRoundMinutes - StartRoundMinutes) div 15
    end.