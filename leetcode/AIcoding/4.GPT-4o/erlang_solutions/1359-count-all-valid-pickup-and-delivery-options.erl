-module(solution).
-export([count_orders/1]).

count_orders(N) ->
    Mod = 1000000007,
    Factorial = lists:foldl(fun(X, Acc) -> (Acc * X) rem Mod end, 1, lists:seq(1, N)),
    Combinations = lists:foldl(fun(X, Acc) -> (Acc * (X * 2 - 1)) rem Mod end, 1, lists:seq(1, N)),
    (Factorial * Combinations) rem Mod.