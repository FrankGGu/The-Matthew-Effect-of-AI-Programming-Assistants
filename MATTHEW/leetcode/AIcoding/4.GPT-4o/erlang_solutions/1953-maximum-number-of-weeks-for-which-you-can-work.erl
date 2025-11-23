-module(solution).
-export([max_weeks/1]).

max_weeks(Workloads) ->
    Total = lists:sum(Workloads),
    Max = lists:max(Workloads),
    if 
        Max > (Total - Max) + 1 -> 
            Total - Max + 1;
        true -> 
            Total
    end.