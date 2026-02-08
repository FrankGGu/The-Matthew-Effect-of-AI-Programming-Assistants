-module(solution).
-export([min_operations/1]).

min_operations(Array) ->
    Min = lists:min(Array),
    lists:sum(lists:map(fun(X) -> X - Min end, Array)).