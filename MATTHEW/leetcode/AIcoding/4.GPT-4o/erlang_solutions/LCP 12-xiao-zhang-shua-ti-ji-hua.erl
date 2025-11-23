-module(solution).
-export([can_complete/2]).

can_complete(N, Tasks) ->
    lists:foldl(fun(X, Acc) -> Acc + X end, 0, Tasks) >= N.