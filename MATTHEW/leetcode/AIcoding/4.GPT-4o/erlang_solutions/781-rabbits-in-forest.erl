-module(solution).
-export([numRabbits/1]).

numRabbits(Rabbits) ->
    case Rabbits of
        [] -> 0;
        _ ->
            Count = lists:foldl(fun(X, Acc) ->
                Acc + (X + 1) div (X + 1)
            end, 0, Rabbits),
            Count
    end.