-module(collecting_chocolates).
-export([min_moves/1]).

min_moves(Chocolates) ->
    lists:foldl(fun(X, Acc) -> X + Acc end, 0, Chocolates).

min_moves(_Args) ->
    0.