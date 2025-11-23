-module(closest_subsequence_sum).
-export([min_abs_diff/2]).

min_abs_diff( nums, goal) ->
    Max = lists:max([0 | nums]),
    Sums = lists:foldl(fun(X, Acc) -> 
        Acc ++ [Y + X || Y <- Acc]
    end, [0], nums),
    lists:foldl(fun(Sum, Best) ->
        case abs(Sum - goal) < abs(Best - goal) of
            true -> Sum;
            false -> Best
        end
    end, 1 shl 30, Sums).