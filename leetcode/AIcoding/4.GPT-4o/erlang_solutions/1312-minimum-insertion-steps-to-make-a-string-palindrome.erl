-module(solution).
-export([min_insertions/1]).

min_insertions(Str) ->
    N = length(Str),
    Dp = lists:duplicate(N + 1, lists:duplicate(N + 1, 0)),
    MinInsertions = calculate(Dp, Str, 1, N),
    MinInsertions.

calculate(Dp, Str, I, J) when I < J ->
    if
        lists:nth(I, Str) =:= lists:nth(J, Str) ->
            Dp1 = calculate(Dp, Str, I + 1, J - 1);
        true ->
            Dp1 = calculate(Dp, Str, I + 1, J),
            Dp2 = calculate(Dp, Str, I, J - 1),
            min(Dp1 + 1, Dp2 + 1)
    end,
    Dp1;
calculate(Dp, _, _, _) ->
    0.

min(X, Y) ->
    if
        X < Y -> X;
        true -> Y
    end.