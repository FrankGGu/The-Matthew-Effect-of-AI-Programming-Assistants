-module(minimum_operations_to_exceed_threshold_value_ii).
-export([minOperations/2]).

minOperations(Nums, Threshold) ->
    N = length(Nums),
    Sorted = lists:sort(Nums),
    Acc = 0,
    Sum = 0,
    minOperations(Sorted, Threshold, Acc, Sum).

minOperations([], _, Acc, _) -> Acc;
minOperations([H | T], Threshold, Acc, Sum) ->
    NewSum = Sum + H,
    if
        NewSum > Threshold -> Acc + 1;
        true -> minOperations(T, Threshold, Acc + 1, NewSum)
    end.