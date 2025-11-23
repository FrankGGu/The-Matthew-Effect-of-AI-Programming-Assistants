-module(solution).
-export([average/1]).

average(Salaries) ->
    Min = lists:min(Salaries),
    Max = lists:max(Salaries),
    Filtered = lists:filter(fun(X) -> X /= Min andalso X /= Max end, Salaries),
    Total = lists:sum(Filtered),
    Count = length(Filtered),
    if Count > 0 -> Total / Count; 
    true -> 0.0 
    end.