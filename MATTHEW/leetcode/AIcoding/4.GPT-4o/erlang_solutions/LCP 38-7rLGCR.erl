-module(solution).
-export([guard_castle/1]).

guard_castle(Castle) ->
    lists:foldl(fun({X, Y}, Acc) ->
        Acc + (if 
            X > 0 -> 1; 
            true -> 0 
        end)
    end, 0, Castle).