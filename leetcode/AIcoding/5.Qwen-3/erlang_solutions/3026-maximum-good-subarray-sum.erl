-module(max_good_subarray_sum).
-export([maxGoodSubarraySum/1]).

maxGoodSubarraySum(Numbers) ->
    max_good_subarray_sum(Numbers, 0, 0, 0).

max_goodSubarraySum([], _Start, _CurrentSum, MaxSum) ->
    MaxSum;
max_goodSubarraySum([H | T], Start, CurrentSum, MaxSum) ->
    case H of
        0 ->
            max_good_subarray_sum(T, Start + 1, 0, MaxSum);
        _ ->
            NewCurrent = CurrentSum + H,
            NewMax = max(MaxSum, NewCurrent),
            max_good_subarray_sum(T, Start, NewCurrent, NewMax)
    end.

max_good_subarray_sum(Numbers, Start, CurrentSum, MaxSum) ->
    max_goodSubarraySum(Numbers, Start, CurrentSum, MaxSum).