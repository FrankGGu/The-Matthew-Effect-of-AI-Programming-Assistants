-module(solution).
-export([divide_string/2]).

divide_string(Str, K) ->
    lists:map(fun(X) -> lists:sublist(Str, X*K, K) end,
               lists:seq(0, (length(Str) div K) - 1)).