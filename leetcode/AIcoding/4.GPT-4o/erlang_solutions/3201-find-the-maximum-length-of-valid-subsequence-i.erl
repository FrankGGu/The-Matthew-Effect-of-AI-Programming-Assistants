-module(solution).
-export([find_max_length/2]).

find_max_length(A, B) ->
    lists:foldl(fun(X, Acc) -> 
        if 
            lists:any(fun(Y) -> Y > X end, B) -> 
                Acc + 1 
            ; 
                Acc 
        end 
    end, 0, A).