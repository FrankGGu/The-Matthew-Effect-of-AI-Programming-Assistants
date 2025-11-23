-module(solution).
-export([count_characters/2]).

count_characters(operations, s) ->
    lists:sum(lists:map(fun(X) -> string:len(X) end, operations)) + string:len(s).