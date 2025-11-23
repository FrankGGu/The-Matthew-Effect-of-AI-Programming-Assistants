-module(least_ops).
-export([least_ops/1]).

least_ops(X) ->
    least_ops(X, 1).

least_ops(X, Target) ->
    least_ops(X, Target, 0).

least_ops(X, Target, Start) ->
    case Target of
        0 -> Start - 1;
        1 -> min(Start, Start + 1 + least_ops(X, X - 1, 0));
        _ ->
            P = 0,
            while math:pow(X, P) =< Target do
                P = P + 1
            end,
            case math:pow(X, P) == Target of
                true -> Start + P - 1;
                false ->
                    P1 = P - 1,
                    res1 = Start + P1 - 1 + least_ops(X, Target - trunc(math:pow(X, P1)), 1),
                    res2 = Start + P + least_ops(X, trunc(math:pow(X, P)) - Target, 1),
                    min(res1, res2)
            end
    end.