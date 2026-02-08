-module(solution).
-export([cook/1]).

cook(Ingredients) ->
    lists:map(fun({Recipe, Time}) -> {Recipe, Time * length(Ingredients)} end, Ingredients).