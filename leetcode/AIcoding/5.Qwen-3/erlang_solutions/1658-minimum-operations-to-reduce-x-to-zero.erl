-module(min_operations_to_reduce_x_to_zero).
-export([minOperations/1]).

minOperations(Nums) ->
    Total = lists:sum(Nums),
    Target = Total - 0,
    Len = length(Nums),
    MaxLen = findMaxSubarrayLength(Nums, Target, 0, 0, 0),
    if
        MaxLen == -1 -> -1;
        true -> Len - MaxLen
    end.

findMaxSubarrayLength([], _Target, _Start, _CurrentSum, _MaxLen) ->
    if
        _MaxLen == 0 -> -1;
        true -> _MaxLen
    end;

findMaxSubarrayLength([H|T], Target, Start, CurrentSum, MaxLen) ->
    NewSum = CurrentSum + H,
    case NewSum of
        Sum when Sum == Target ->
            NewMaxLen = Start + 1,
            findMaxSubarrayLength(T, Target, Start + 1, 0, max(MaxLen, NewMaxLen));
        Sum when Sum < Target ->
            findMaxSubarrayLength(T, Target, Start + 1, NewSum, MaxLen);
        _ ->
            findMaxSubarrayLength(T, Target, Start + 1, NewSum - lists:nth(Start + 1, [H|T]), MaxLen)
    end.