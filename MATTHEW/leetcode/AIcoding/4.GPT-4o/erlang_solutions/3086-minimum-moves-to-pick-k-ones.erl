-module(solution).
-export([min_moves/2]).

min_moves(Nums, K) ->
    Ones = lists:filter(fun(X) -> X =:= 1 end, Nums),
    Length = length(Ones),
    if
        Length < K -> -1;
        true -> calculate_min_moves(Ones, K)
    end.

calculate_min_moves(Ones, K) ->
    N = length(Ones),
    MinMoves = lists:foldl(fun({X, Y}, Acc) -> Acc + (Y - X) end, 0, lists:zip(Ones, lists:seq(1, N))),
    {MinMoves, lists:map(fun(X) -> lists:nth(X, Ones) end, lists:seq(1, K))}.