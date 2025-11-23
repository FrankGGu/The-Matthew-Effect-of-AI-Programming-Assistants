-module(solution).
-export([maximum_operations/2]).

maximum_operations(A, B) ->
    lists:sum(lists:map(fun(X) -> if X =< B -> 1; true -> 0 end end, A).