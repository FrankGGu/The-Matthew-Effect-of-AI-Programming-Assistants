-module(solution).
-export([min_increment_operations/1]).

min_increment_operations(A) ->
    N = length(A),
    MinInc = lists:foldl(fun(X, {Prev, Acc}) ->
        if
            X < Prev -> {Prev, Acc + (Prev - X)};
            true -> {X, Acc}
        end
    end, {0, 0}, lists:reverse(A)),
    element(2, MinInc).