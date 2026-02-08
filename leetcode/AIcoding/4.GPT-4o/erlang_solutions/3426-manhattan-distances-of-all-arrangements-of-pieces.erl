-module(solution).
-export([manhattan_distance/1]).

manhattan_distance(Pieces) ->
    N = length(Pieces),
    Lists = lists:seq(1, N),
    permutations(Lists, Pieces, 0).

permutations([], _, Acc) -> 
    Acc;
permutations(Pieces, Remaining, Acc) ->
    lists:foldl(fun(X, Acc1) ->
        NewPieces = lists:delete(X, Remaining),
        NewAcc = Acc1 + calculate_distance(Pieces, [X | Remaining]),
        permutations(Pieces, NewPieces, NewAcc)
    end, Acc, Remaining).

calculate_distance(Pieces, Arrangement) ->
    lists:sum(lists:map(fun({P, A}) -> abs(P - A) end, lists:zip(Pieces, Arrangement))).