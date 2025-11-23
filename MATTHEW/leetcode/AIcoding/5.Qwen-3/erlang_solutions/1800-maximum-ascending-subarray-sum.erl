-module(maximum_ascending_subarray_sum).
-export([max_ascending_sum/1]).

max_ascending_sum([]) -> 0;
max_ascending_sum([H|T]) ->
    max_ascending_sum(T, H, H, 0).

max_ascending_sum([], _, _, Max) -> Max;
max_ascending_sum([H|T], Current, Start, Max) ->
    if
        H > Start ->
            NewCurrent = Current + H,
            NewStart = H,
            NewMax = max(Max, NewCurrent),
            max_ascending_sum(T, NewCurrent, NewStart, NewMax);
        true ->
            NewCurrent = H,
            NewStart = H,
            NewMax = max(Max, NewCurrent),
            max_ascending_sum(T, NewCurrent, NewStart, NewMax)
    end.