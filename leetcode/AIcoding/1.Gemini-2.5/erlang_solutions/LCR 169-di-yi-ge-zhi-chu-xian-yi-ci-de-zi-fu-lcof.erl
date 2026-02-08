-module(solution).
-export([solve/1]).

solve(String) when is_list(String) ->
    string:tokens(String, " ").