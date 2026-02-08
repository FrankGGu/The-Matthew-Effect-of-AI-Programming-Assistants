-module(pivot_integer).
-export([pivot_integer/1]).

pivot_integer(N) ->
    X = math:sqrt(N * (N + 1) / 2),
    if
        X == trunc(X) -> trunc(X);
        true -> -1
    end.