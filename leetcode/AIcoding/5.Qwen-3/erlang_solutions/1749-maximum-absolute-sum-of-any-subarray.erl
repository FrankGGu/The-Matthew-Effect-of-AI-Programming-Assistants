-module(max_abs_sum).
-export([maxAbsoluteSum/1]).

maxAbsoluteSum(Nums) ->
    max_abs_sum(Nums, 0, 0, 0).

max_abs_sum([], _, Max, _) ->
    Max;
max_abs_sum([H | T], CurrentSum, Max, Min) ->
    CurrentSum1 = CurrentSum + H,
    NewMax = max(Max, abs(CurrentSum1)),
    NewMin = min(Min, abs(CurrentSum1)),
    max_abs_sum(T, CurrentSum1, NewMax, NewMin).