-module(solution).
-export([solve/1]).

solve(Books) ->
    lists:sort(Books).