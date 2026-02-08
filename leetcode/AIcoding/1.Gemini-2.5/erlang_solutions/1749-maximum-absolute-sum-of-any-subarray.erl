-module(solution).
-export([max_absolute_sum/1]).

max_absolute_sum(Nums) ->
    MaxSum = max_subarray_sum(Nums),
    MinSum = min_subarray_sum(Nums),
    max(abs(MaxSum), abs(MinSum)).

max_subarray_sum([H|T]) ->
    max_subarray_sum_impl(T, H, H).

max_subarray_sum_impl([], MaxSoFar, _) ->
    MaxSoFar;
max_subarray_sum_impl([H|T], MaxSoFar, CurrentMax) ->
    NewCurrentMax = max(H, CurrentMax + H),
    NewMaxSoFar = max(MaxSoFar, NewCurrentMax),
    max_subarray_sum_impl(T, NewMaxSoFar, NewCurrentMax).

min_subarray_sum([H|T]) ->
    min_subarray_sum_impl(T, H, H).

min_subarray_sum_impl([], MinSoFar, _) ->
    MinSoFar;
min_subarray_sum_impl([H|T], MinSoFar, CurrentMin) ->
    NewCurrentMin = min(H, CurrentMin + H),
    NewMinSoFar = min(MinSoFar, NewCurrentMin),
    min_subarray_sum_impl(T, NewMinSoFar, NewCurrentMin).