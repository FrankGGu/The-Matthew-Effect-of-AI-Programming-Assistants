-module(solution).
-export([maximum_height/1]).

maximum_height(Sides) ->
    lists:foldl(fun(X, Acc) -> min(X, Acc) end, 0, Sides).