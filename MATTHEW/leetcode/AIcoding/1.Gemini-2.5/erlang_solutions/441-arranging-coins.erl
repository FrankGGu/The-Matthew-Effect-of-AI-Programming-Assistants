-module(solution).
-export([arrangeCoins/1]).

arrangeCoins(N) ->
    Val = math:sqrt(1.0 + 8.0 * N),
    ResultFloat = (-1.0 + Val) / 2.0,
    trunc(ResultFloat).