-module(solution).
-export([minimum_time/1]).

minimum_time(Cars) ->
    lists:foldl(fun(X, Acc) -> 
        case X of 
            1 -> Acc + 1; 
            _ -> Acc + 2 
        end 
    end, 0, Cars).