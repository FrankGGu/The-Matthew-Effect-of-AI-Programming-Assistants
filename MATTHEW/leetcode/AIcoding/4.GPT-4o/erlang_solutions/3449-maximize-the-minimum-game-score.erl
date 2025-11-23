-module(solution).
-export([minimize_game/1]).

minimize_game(N) ->
    lists:foldl(fun(X, Acc) -> min(X, Acc) end, N, lists:seq(1, N)).