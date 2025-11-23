-module(solution).
-export([minimum_sum/2]).

minimum_sum(N, K) ->
    lists:sum(lists:sort(1, lists:seq(1, N))) - (length(lists:filter(fun(X) -> X rem K =:= 0 end, lists:seq(1, N)))).