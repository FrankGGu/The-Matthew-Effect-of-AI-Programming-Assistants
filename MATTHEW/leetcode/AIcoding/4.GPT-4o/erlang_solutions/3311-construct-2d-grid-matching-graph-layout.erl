-module(solution).
-export([construct_grid/2]).

construct_grid(N, M) ->
    lists:map(fun(X) -> lists:seq(1, M) end, lists:seq(1, N)).