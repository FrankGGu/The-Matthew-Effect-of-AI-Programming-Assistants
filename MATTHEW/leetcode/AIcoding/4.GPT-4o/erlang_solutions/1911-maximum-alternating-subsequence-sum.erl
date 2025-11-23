-module(solution).
-export([max_alternating_sum/1]).

max_alternating_sum(Nums) ->
    max_alternating_sum(Nums, 0, 0).

max_alternating_sum([], PrevSum, _) ->
    PrevSum;
max_alternating_sum([H | T], PrevSum, PrevSign) ->
    NewSum = PrevSum + H,
    NewSign = if PrevSum >= 0 -> 1; true -> -1 end,
    max_alternating_sum(T, max(NewSum, PrevSum), NewSign).