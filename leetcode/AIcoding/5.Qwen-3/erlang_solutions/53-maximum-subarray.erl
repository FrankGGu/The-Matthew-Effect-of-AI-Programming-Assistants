-module(maximum_subarray).
-export([max_subarray/1]).

max_subarray([]) -> 0;
max_subarray([H | T]) ->
    max_subarray(T, H, H).

max_subarray([], current, max) -> max;
max_subarray([H | T], Current, Max) ->
    NewCurrent = max(H, Current + H),
    NewMax = max(Max, NewCurrent),
    max_subarray(T, NewCurrent, NewMax).