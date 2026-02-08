-module(solution).
-export([idealArrays/2]).

idealArrays(N, K) ->
    M = 10^9 + 7,
    Counts = lists:duplicate(N + 1, 0),
    Counts = lists:map(fun(X) -> fastPow(X, K, M) end, lists:seq(1, N)),
    lists:sum(Counts) rem M.

fastPow(X, Y, M) when Y =:= 0 -> 1;
fastPow(X, Y, M) when Y rem 2 =:= 0 -> 
    (fastPow((X * X) rem M, Y div 2, M) rem M);
fastPow(X, Y, M) -> 
    (X * fastPow(X, Y - 1, M)) rem M.