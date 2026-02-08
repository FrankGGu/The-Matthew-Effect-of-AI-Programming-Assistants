-module(solution).
-export([min_operations/1]).

min_operations(List) ->
    lists:sum(lists:map(fun(X) -> (3 - (X rem 3)) rem 3 end, List)).