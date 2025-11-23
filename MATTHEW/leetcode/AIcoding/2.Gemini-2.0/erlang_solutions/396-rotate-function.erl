-module(rotate_function).
-export([max_rotate_function/1]).

max_rotate_function(A) ->
    N = length(A),
    Sum = lists:sum(A),
    F0 = lists:foldl(fun({X, I}, Acc) -> Acc + X * I end, 0, lists:zip(A, lists:seq(0, N - 1))),
    max_rotate_function(A, N, Sum, F0, F0).

max_rotate_function(_, 0, _, Max, Acc) ->
    Acc;
max_rotate_function(A, N, Sum, F, Acc) ->
    FNext = F + Sum - N * lists:nth(N - 1, A),
    max_rotate_function(A, N - 1, Sum, FNext, max(Acc, FNext)).