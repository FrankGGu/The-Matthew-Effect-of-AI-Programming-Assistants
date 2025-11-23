-module(solution).
-export([training_plan_vi/2]).

training_plan_vi(N, days) ->
    Max = lists:max(days),
    Min = lists:min(days),
    Sum = lists:sum(days),
    Average = Sum div N,
    if 
        Average > Min -> 
            Max - Average;
        true -> 
            Max - Min
    end.