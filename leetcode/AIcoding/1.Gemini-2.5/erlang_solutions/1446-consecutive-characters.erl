-module(solution).
-export([maxPower/1]).

maxPower(S) ->
    case S of
        [] -> 0;
        [H|T] -> max_power_helper(T, 1, H, 1)
    end.

max_power_helper([], CurrentMax, _, _) ->
    CurrentMax;
max_power_helper([H|T], CurrentMax, LastChar, CurrentConsecutiveCount) ->
    if H == LastChar ->
        NewCurrentConsecutiveCount = CurrentConsecutiveCount + 1,
        NewCurrentMax = max(CurrentMax, NewCurrentConsecutiveCount),
        max_power_helper(T, NewCurrentMax, H, NewCurrentConsecutiveCount);
    true ->
        NewCurrentConsecutiveCount = 1,
        NewCurrentMax = max(CurrentMax, NewCurrentConsecutiveCount),
        max_power_helper(T, NewCurrentMax, H, NewCurrentConsecutiveCount)
    end.