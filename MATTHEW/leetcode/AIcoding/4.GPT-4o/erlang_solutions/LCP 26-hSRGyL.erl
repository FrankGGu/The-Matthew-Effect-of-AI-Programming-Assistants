-module(solution).
-export([navigate/1]).

navigate(Commands) ->
    lists:foldl(fun
        "U" -> fun({X, Y}) -> {X, Y + 1} end;
        "D" -> fun({X, Y}) -> {X, Y - 1} end;
        "L" -> fun({X, Y}) -> {X - 1, Y} end;
        "R" -> fun({X, Y}) -> {X + 1, Y} end
    end, fun({X, Y}) -> {X, Y} end, Commands).