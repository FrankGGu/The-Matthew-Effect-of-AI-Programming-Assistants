-module(solution).
-export([min_cost/1]).

min_cost(List) ->
    Sorted = lists:sort(List),
    N = length(List),
    Median = lists:nth((N div 2) + 1, Sorted),
    lists:sum(lists:map(fun(X) -> abs(X - Median) end, List)).