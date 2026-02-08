-module(solution).
-export([maximum_sum/2]).

maximum_sum(N, K) ->
    lists:sum(lists:sublist(lists:sort(fun(X, Y) -> X > Y end, N), K)).