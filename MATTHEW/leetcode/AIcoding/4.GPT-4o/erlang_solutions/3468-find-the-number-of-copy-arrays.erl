-module(solution).
-export([count_copy_arrays/1]).

count_copy_arrays(N) when N > 0 ->
    Mod = 1000000007,
    Factorial = lists:foldl(fun(X, Acc) -> (Acc * X) rem Mod end, 1, lists:seq(1, N)),
    Factorial.