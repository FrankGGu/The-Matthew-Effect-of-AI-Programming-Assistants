-module(solution).
-export([find_building/3]).

find_building(N, F, S) ->
    lists:foldl(fun ({X, Y}, Acc) ->
        case lists:member(X, S) of
            true -> 
                {X, Y + Acc};
            false -> 
                Acc
        end
    end, 0, lists:zip(lists:seq(1, N), F)).