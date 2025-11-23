-module(solution).
-export([min_operations/1]).

min_operations(Array) ->
    MinOps = lists:foldl(fun(X, Acc) -> 
        case X of
            1 -> Acc;
            _ -> Acc + 1
        end
    end, 0, Array),
    MinOps.