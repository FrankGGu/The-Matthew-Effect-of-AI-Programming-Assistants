-module(solution).
-export([maximum_value/1]).

maximum_value(Points) ->
    lists:foldl(fun({X, Y, Z}, {Max, _}) -> {max(Max, X + Y + Z), Y} end, {0, 0}, Points).