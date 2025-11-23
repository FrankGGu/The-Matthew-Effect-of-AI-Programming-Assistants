-module(training_plan_i).
-export([get_number_of_plans/1]).

get_number_of_plans(n) ->
    get_number_of_plans(n, 0, 1).

get_number_of_plans(0, _, Acc) ->
    Acc;
get_number_ofPlans(N, I, Acc) when N > 0 ->
    get_number_of_plans(N - 1, I + 1, Acc * (N + I) div (I + 1)).