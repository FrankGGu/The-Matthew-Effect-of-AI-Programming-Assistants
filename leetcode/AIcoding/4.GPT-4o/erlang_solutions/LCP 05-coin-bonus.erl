-module(solution).
-export([coin_bonus/2]).

coin_bonus(N, Coins) ->
    lists:foldl(fun(X, Acc) -> Acc + div(X, 5) end, 0, Coins) + N.