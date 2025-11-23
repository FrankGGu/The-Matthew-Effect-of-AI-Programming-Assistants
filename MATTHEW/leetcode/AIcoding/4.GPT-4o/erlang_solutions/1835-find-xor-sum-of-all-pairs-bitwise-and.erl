-module(solution).
-export([xor_sum/1]).

xor_sum(N) ->
    lists:foldl(fun(X, Acc) -> Acc bxor (X band (N - 1)) end, 0, lists:seq(1, N)).