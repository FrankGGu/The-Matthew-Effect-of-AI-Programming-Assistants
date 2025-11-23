-module(subarray_threshold).
-export([validSubarraySize/2]).

validSubarraySize(Nums, Threshold) ->
    validSubarraySize(Nums, Threshold, 1, length(Nums)).

validSubarraySize(Nums, Threshold, Start, End) ->
    case Start > End of
        true ->
            false;
        false ->
            Mid = (Start + End) div 2,
            MinVal = findMin(Nums, Start, Mid),
            case MinVal > Threshold / Mid of
                true ->
                    true;
                false ->
                    validSubarraySize(Nums, Threshold, Start, Mid - 1) orelse
                        validSubarraySize(Nums, Threshold, Mid + 1, End)
            end
    end.

findMin(Nums, Start, End) ->
    findMin(Nums, Start, End, lists:nth(Start, Nums)).

findMin(Nums, Start, End, Acc) ->
    case Start > End of
        true ->
            Acc;
        false ->
            Val = lists:nth(Start, Nums),
            NewAcc = min(Acc, Val),
            findMin(Nums, Start + 1, End, NewAcc)
    end.