-module(solution).
-export([max_distance/1]).

max_distance(Grid) ->
    MaxDist = lists:foldl(fun({X, Y}, Acc) -> 
        Max = lists:foldl(fun({Nx, Ny}, DAcc) -> 
            case lists:member({Nx, Ny}, Acc) of
                true -> DAcc;
                false -> max(DAcc, abs(Nx - X) + abs(Ny - Y))
            end
        end, Acc, [{X + 1, Y}, {X - 1, Y}, {X, Y + 1}, {X, Y - 1}])
    end, 0, lists:flatmap(fun(X) -> lists:map(fun(Y) -> {X, Y} end, lists:seq(0, length(Grid) - 1)) end, lists:seq(0, length(Grid) - 1))),
    MaxDist.