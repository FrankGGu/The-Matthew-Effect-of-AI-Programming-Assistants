-module(solution).
-export([min_partitions/1]).

min_partitions(N) ->
    lists:max(lists:map(fun(C) -> list_to_integer([C]) end, string:to_list(N))).