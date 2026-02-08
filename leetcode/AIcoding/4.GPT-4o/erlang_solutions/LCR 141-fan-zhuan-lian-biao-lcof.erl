-module(solution).
-export([fitness/3]).

fitness(N, T, T_max) ->
    Max = lists:max(T),
    Total = lists:sum(T),
    (Total + N * Max) div (N + 1) =< T_max.