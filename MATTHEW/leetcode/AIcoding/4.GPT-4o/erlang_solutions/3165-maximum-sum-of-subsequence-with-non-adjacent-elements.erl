-module(solution).
-export([max_sum/1]).

max_sum(Nums) ->
    max_sum_helper(Nums, 0, 0).

max_sum_helper([], PrevMax, CurrMax) ->
    max(PrevMax, CurrMax);
max_sum_helper([H | T], PrevMax, CurrMax) ->
    NewCurrMax = max(CurrMax, PrevMax + H),
    max_sum_helper(T, CurrMax, NewCurrMax).