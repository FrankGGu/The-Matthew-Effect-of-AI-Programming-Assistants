-module(solution).
-export([min_operations/2]).

min_operations(A, x) ->
    lists:foldl(fun(Y, Acc) -> 
        if 
            Acc >= x -> 
                Acc 
        else 
            Acc + Y 
        end 
    end, 0, lists:sort(A)).