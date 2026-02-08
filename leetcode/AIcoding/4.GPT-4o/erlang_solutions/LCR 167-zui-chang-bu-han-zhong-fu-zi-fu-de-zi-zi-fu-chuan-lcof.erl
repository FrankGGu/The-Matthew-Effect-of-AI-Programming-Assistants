-module(solution).
-export([solve/1]).

solve(N) when N >= 1, N =< 1000 ->
    lists:sum(lists:map(fun(X) -> X * X end, lists:seq(1, N))).