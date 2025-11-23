-module(solution).
-export([min_operations/2]).

min_operations(N, A) ->
    Max = lists:max(A),
    MinOps = lists:foldl(fun(X, Acc) ->
        if
            X < Max -> Acc + (Max - X);
            true -> Acc
        end
    end, 0, A),
    MinOps.