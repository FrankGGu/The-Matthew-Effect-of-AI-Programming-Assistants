-module(solution).
-export([solve/1]).

solve(Target) ->
    solve([], Target).

solve(Arr, Target) ->
    lists:foldl(fun(X, Acc) -> Acc + X end, 0, Arr) - Target.