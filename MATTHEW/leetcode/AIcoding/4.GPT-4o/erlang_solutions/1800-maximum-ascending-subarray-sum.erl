-module(solution).
-export([max_ascending_sum/1]).

max_ascending_sum(List) ->
    max_ascending_sum(List, 0, 0).

max_ascending_sum([], Max) ->
    Max;
max_ascending_sum([H | T], Current) ->
    NewCurrent = if
        Current =:= 0 orelse H > Current -> Current + H;
        true -> H
    end,
    max_ascending_sum(T, NewCurrent, max(NewCurrent, Max)).