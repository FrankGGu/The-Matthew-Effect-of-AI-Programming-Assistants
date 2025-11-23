-module(solution).
-export([training_plan/2]).

training_plan(N, A) ->
    Max = lists:max(A),
    lists:foldl(fun(X, Acc) -> Acc + (Max - X) end, 0, A) div N.