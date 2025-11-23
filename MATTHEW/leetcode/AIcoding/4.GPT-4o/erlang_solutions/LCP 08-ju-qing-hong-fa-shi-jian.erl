-module(solution).
-export([min_time/2]).

min_time(A, B) ->
    lists:foldl(fun({X, Y}, Acc) -> 
        case A of
            0 -> Acc + X;
            _ -> Acc + X + (A div Y)
        end
    end, 0, B).