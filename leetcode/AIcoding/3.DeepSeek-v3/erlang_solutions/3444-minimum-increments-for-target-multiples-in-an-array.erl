-module(solution).
-export([min_increments/2]).

min_increments(Target, A) ->
    lists:foldl(fun(X, {Sum, Res}) ->
        NewSum = Sum + X,
        if
            NewSum > Target -> {Target, Res + (NewSum - Target)};
            true -> {NewSum, Res}
        end
    end, {0, 0}, A).