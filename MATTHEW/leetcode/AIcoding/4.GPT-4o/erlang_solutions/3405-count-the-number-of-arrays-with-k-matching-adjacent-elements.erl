-module(solution).
-export([count_arrays/3]).

count_arrays(N, K, R) ->
    M = 10^9 + 7,
    F = fun(X, Y) -> 
        (if 
            X == 0 -> 
                Y 
        ; 
            Y == 0 -> 
                X 
        ; 
            (X + Y) rem M 
        end)
    end,
    lists:foldl(fun({_, _, _}, Acc) -> 
        Acc 
    end, 0, lists:seq(1, K)).