-module(solution).
-export([maxAbsoluteSum/1]).

maxAbsoluteSum(List) ->
    MaxSum = max_subarray_sum(List, 0, 0),
    MinSum = min_subarray_sum(List, 0, 0),
    max(abs(MaxSum), abs(MinSum)).

max_subarray_sum([], Max) -> Max;
max_subarray_sum([H | T], Max) ->
    NewMax = max(H, Max + H),
    max_subarray_sum(T, NewMax).

min_subarray_sum([], Min) -> Min;
min_subarray_sum([H | T], Min) ->
    NewMin = min(H, Min + H),
    min_subarray_sum(T, NewMin).