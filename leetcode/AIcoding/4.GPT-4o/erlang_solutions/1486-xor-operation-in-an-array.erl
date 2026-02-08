-module(solution).
-export([xorOperation/2]).

xorOperation(N, Start) ->
    lists:foldl(fun(X, Acc) -> Acc bxor X end, 0, lists:map(fun(I) -> Start + 2 * I end, lists:seq(0, N - 1))).