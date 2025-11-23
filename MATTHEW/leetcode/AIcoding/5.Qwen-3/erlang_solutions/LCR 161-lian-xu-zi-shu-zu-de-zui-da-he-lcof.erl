-module(solution).
-export([max_consecutive_sales/1]).

max_consecutive_sales(Sales) ->
    max_consecutive_sales(Sales, 0, 0).

max_consecutive_sales([], Current, Max) ->
    Max;
max_consecutive_sales([0 | Rest], _, Max) ->
    max_consecutive_sales(Rest, 0, Max);
max_consecutive_sales([_ | Rest], Current, Max) ->
    NewCurrent = Current + 1,
    NewMax = max(Max, NewCurrent),
    max_consecutive_sales(Rest, NewCurrent, NewMax).