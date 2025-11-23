-module(maximum_alternating_subsequence_sum).
-export([maximumAlternatingSubsequenceSum/1]).

maximumAlternatingSubsequenceSum(Nums) ->
    maximumAlternatingSubsequenceSum(Nums, 0, 1, 0).

maximumAlternatingSubsequenceSum([], _EvenSum, _OddSum, MaxSum) ->
    MaxSum;
maximumAlternatingSubsequenceSum([H|T], EvenSum, OddSum, MaxSum) ->
    NewEvenSum = max(EvenSum + H, EvenSum),
    NewOddSum = max(OddSum - H, OddSum),
    maximumAlternatingSubsequenceSum(T, NewEvenSum, NewOddSum, max(max(NewEvenSum, NewOddSum), MaxSum)).