-module(solution).
-export([max_elements/2]).

max_elements(N, A) ->
    lists:foldl(fun(X, Acc) -> 
        if 
            X =< N -> Acc + 1; 
            true -> Acc 
        end 
    end, 0, A).