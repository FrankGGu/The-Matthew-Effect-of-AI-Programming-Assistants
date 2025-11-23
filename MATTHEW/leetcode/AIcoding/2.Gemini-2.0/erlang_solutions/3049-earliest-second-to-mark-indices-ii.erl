-module(earliest_second_to_mark_indices_ii).
-export([earliestSecondToMarkIndices/2]).

earliestSecondToMarkIndices(Nums, ChangeIndices) ->
    earliestSecondToMarkIndicesHelper(Nums, ChangeIndices, 1, length(ChangeIndices)).

earliestSecondToMarkIndicesHelper(Nums, ChangeIndices, Low, High) ->
    if Low > High then
        -1
    else
        Mid = (Low + High) div 2,
        if canMark(Nums, ChangeIndices, Mid) then
            if Low == High orelse not canMark(Nums, ChangeIndices, Mid - 1) then
                Mid
            else
                earliestSecondToMarkIndicesHelper(Nums, ChangeIndices, Low, Mid - 1)
            end
        else
            earliestSecondToMarkIndicesHelper(Nums, ChangeIndices, Mid + 1, High)
        end
    end.

canMark(Nums, ChangeIndices, T) ->
    {Result, _} = canMarkHelper(Nums, ChangeIndices, T, [], 0, 0),
    Result.

canMarkHelper(_Nums, _ChangeIndices, 0, _Used, _Idx, Marked) ->
    {Marked == length(_Nums), _Used};
canMarkHelper(Nums, ChangeIndices, T, Used, Idx, Marked) ->
    Index = lists:nth(T, ChangeIndices),
    if lists:member(T, Used) then
        canMarkHelper(Nums, ChangeIndices, T - 1, Used, Idx, Marked)
    else
        if Nums[Index] > 0 then
            NewNums = Nums#{},
            NewNums[Index] = NewNums[Index] - 1,
            {Result, NewUsed} = canMarkHelper(NewNums, ChangeIndices, T - 1, Used, Idx, Marked),
            if Result then
                {Result, NewUsed}
            else
                canMarkHelper(Nums, ChangeIndices, T - 1, [T | Used], Idx, Marked + 1)
            end
        else
            canMarkHelper(Nums, ChangeIndices, T - 1, Used, Idx, Marked)
        end
    end.