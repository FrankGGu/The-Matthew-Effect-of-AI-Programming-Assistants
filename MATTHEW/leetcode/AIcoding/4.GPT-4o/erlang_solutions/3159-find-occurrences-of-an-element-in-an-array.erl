-module(solution).
-export([count_occurrences/2]).

count_occurrences(Array, Target) ->
    lists:sum(lists:map(fun(X) -> if X == Target -> 1; true -> 0 end end, Array)).