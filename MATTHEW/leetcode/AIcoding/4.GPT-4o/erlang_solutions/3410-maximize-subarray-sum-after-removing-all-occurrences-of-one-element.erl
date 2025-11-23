-module(solution).
-export([max_sum_after_removing/2]).

max_sum_after_removing(A, val) ->
    MaxSum = lists:max(A),
    lists:foldl(fun(X, Acc) -> 
        if 
            X =:= val -> 
                Acc 
            ; 
                Acc + X 
        end 
    end, 0, A) - MaxSum.