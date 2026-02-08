-module(solution).
-export([capitalize/1]).

capitalize(S) ->
    lists:map(fun(C) -> string:to_upper(C) end, string:tokens(S, " ")).