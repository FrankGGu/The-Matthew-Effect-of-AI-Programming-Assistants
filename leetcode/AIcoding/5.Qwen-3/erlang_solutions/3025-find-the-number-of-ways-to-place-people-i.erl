-module(solution).
-export([numberOfWaysToPlace/1]).

numberOfWaysToPlace(Positions) ->
    lists:foldl(fun({X, Y}, Acc) -> 
        lists:foldl(fun({A, B}, Acc2) -> 
            if X == A andalso Y == B -> Acc2;
               true -> Acc2 + 1
            end
        end, 0, Positions)
    end, 0, Positions).