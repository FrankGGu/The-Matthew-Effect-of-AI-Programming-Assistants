-module(solution).
-export([max_subarray/1]).

max_subarray([H|T]) ->
    max_subarray_recursive(T, H, H).

max_subarray_recursive([], MaxSoFar, _CurrentMax) ->
    MaxSoFar;
max_subarray_recursive([H|T], MaxSoFar, CurrentMax) ->
    NewCurrentMax = max(H, CurrentMax + H),
    NewMaxSoFar = max(MaxSoFar, NewCurrentMax),
    max_subarray_recursive(T, NewMaxSoFar, NewCurrentMax).