-module(solution).
-export([max_subsequence_sum/2]).

max_subsequence_sum(A, K) ->
    lists:sublist(lists:sort(fun(X, Y) -> X > Y end, A), K).