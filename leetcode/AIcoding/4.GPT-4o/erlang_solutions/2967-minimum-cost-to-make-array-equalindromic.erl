-module(solution).
-export([min_cost/1]).

min_cost(N) ->
    Total = (N * (N + 1)) div 2,
    Total - (N * (N div 2)).