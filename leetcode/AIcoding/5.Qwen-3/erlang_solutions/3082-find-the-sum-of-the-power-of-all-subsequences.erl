-module(solution).
-export([sum_power/1]).

sum_power(Numbers) ->
    sum_power(Numbers, 0, 0, 0).

sum_power([], _Min, _Max, Acc) ->
    Acc;
sum_power([N | Rest], Min, Max, Acc) ->
    NewMin = if N < Min -> N; true -> Min end,
    NewMax = if N > Max -> N; true -> Max end,
    sum_power(Rest, NewMin, NewMax, Acc + (NewMax - NewMin)).