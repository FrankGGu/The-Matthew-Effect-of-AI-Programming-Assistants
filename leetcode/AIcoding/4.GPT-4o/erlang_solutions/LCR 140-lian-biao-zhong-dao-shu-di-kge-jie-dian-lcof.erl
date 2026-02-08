-module(solution).
-export([training_plan/2]).

training_plan(N, A) ->
    Max = lists:max(A),
    case lists:foldl(fun(X, Acc) -> 
        if 
            X < Max -> Acc + (Max - X) 
        end 
    end, 0, A) of
        0 -> 0;
        Total -> Total div N 
    end.