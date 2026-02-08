-module(solution).
-export([longest_push_time/2]).

longest_push_time(ReleaseTimes, KeysPressed) ->
    [FirstReleaseTime | RestReleaseTimes] = ReleaseTimes,
    [FirstKey | RestKeys] = KeysPressed,

    longest_push_time_acc(RestReleaseTimes, RestKeys, FirstReleaseTime, FirstReleaseTime, FirstKey).

longest_push_time_acc([], [], _PrevReleaseTime, _CurrentMaxDuration, CurrentMaxChar) ->
    CurrentMaxChar;
longest_push_time_acc([R_curr | R_rest], [K_curr | K_rest], PrevReleaseTime, CurrentMaxDuration, CurrentMaxChar) ->
    PushDuration = R_curr - PrevReleaseTime,

    {NewMaxDuration, NewMaxChar} = 
        if
            PushDuration > CurrentMaxDuration ->
                {PushDuration, K_curr};
            PushDuration == CurrentMaxDuration ->
                {CurrentMaxDuration, max(CurrentMaxChar, K_curr)};
            true -> % PushDuration < CurrentMaxDuration
                {CurrentMaxDuration, CurrentMaxChar}
        end,

    longest_push_time_acc(R_rest, K_rest, R_curr, NewMaxDuration, NewMaxChar).