-module(solution).
-export([xor_sum/2]).

xor_sum(A, B) ->
    lists:foldl(fun(X, Acc) -> Acc bxor (lists:foldl(fun(Y, Acc2) -> Acc2 bxor (X band Y) end, 0, B)) end, 0, A).