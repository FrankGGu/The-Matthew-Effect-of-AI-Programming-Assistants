-module(solution).
-export([maxWidthRamp/1]).

maxWidthRamp(A) ->
    max_width_ramp(A, 0, []).

max_width_ramp([], _, _) ->
    0;
max_width_ramp([H | T], Max, Stack) ->
    NewStack = lists:filter(fun(X) -> X =< H end, Stack),
    NewMax = lists:max([Max, lists:max(lists:map(fun(X) -> length(T) - X end, NewStack) ++ [0])]),
    max_width_ramp(T, NewMax, [length(T) | NewStack]).