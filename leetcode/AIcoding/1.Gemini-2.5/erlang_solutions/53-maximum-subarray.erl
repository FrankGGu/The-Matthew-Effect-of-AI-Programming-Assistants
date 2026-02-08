-module(solution).
-export([max_subarray/1]).

max_subarray(Nums) ->
    [H|T] = Nums,
    max_subarray_helper(T, H, H).

max_subarray_helper([], MaxSoFar, _CurrentMax) ->
    MaxSoFar;
max_subarray_helper([H|T], MaxSoFar, CurrentMax) ->
    NewCurrentMax = max(H, CurrentMax + H),
    NewMaxSoFar = max(MaxSoFar, NewCurrentMax),
    max_subarray_helper(T, NewMaxSoFar, NewCurrentMax).