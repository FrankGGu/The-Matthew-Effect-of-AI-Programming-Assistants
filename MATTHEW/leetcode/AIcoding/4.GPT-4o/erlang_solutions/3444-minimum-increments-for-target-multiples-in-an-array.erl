-module(solution).
-export([min_increments/2]).

min_increments(Target, Arr) ->
    lists:foldl(fun(X, Acc) ->
        case X rem Target of
            0 -> Acc;
            R -> Acc + (Target - R)
        end
    end, 0, Arr).