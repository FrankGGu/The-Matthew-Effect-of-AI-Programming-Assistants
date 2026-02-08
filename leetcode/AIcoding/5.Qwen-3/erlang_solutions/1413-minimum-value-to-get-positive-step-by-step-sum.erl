-module(minimum_value_to_get_positive_step_by_step_sum).
-export([minStartValue/1]).

minStartValue(Nums) ->
    min_start_value(Nums, 0, 0).

min_start_value([], _CurrentSum, MinStart) ->
    max(1, 1 - MinStart);

min_start_value([N | Rest], CurrentSum, MinStart) ->
    NewSum = CurrentSum + N,
    NewMinStart = min(MinStart, NewSum),
    min_start_value(Rest, NewSum, NewMinStart).