-module(solution).
-export([count_pairs/2]).

count_pairs(X, Y) ->
    lists:foldl(fun({A, B}, Acc) ->
        Acc + (if 
            A + B =:= 24 -> 1;
            true -> 0
        end)
    end, 0, lists:zip(X, Y)).