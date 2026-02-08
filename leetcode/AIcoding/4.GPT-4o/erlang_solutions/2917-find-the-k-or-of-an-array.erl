-module(solution).
-export([k_or/2]).

k_or(A, K) ->
    lists:foldl(fun(X, Acc) -> Acc bor X end, 0, A) band K.