-module(solution).
-export([add_column/1]).

add_column(List) ->
    lists:map(fun(X) -> X + 1 end, List).