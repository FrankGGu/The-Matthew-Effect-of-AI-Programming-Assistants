-module(solution).
-export([min_cost/2]).

min_cost(A, B) ->
    TotalA = lists:foldl(fun(X, Acc) -> Acc + X end, 0, A),
    TotalB = lists:foldl(fun(X, Acc) -> Acc + X end, 0, B),
    MinA = lists:min(A),
    MinB = lists:min(B),
    TotalA + TotalB - (length(A) * MinA + length(B) * MinB).