-module(solution).
-export([split_string/2]).

split_string(String, Separator) ->
    StringList = string:tokens(String, Separator),
    lists:map(fun(X) -> X end, StringList).