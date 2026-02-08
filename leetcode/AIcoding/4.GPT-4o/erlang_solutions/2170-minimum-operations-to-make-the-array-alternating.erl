-module(solution).
-export([minimum_operations/1]).

minimum_operations(Array) ->
    counts = lists:foldl(fun(X, Acc) ->
        {Even, Odd} = Acc,
        case lists:nth(1, X) rem 2 of
            0 -> {Even + 1, Odd};
            _ -> {Even, Odd + 1}
        end
    end, {0, 0}, lists:zip(Array, lists:seq(1, length(Array))),

    min(Even, Odd) where
    Even = element(1, counts),
    Odd = element(2, counts).