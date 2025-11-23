-module(solution).
-export([manhattan_distance/2]).

manhattan_distance(Points1, Points2) ->
    lists:sum([abs(X1 - X2) + abs(Y1 - Y2) || {X1, Y1} <- Points1, {X2, Y2} <- Points2]).

permute([]) -> [[]];
permute(L) -> [[H|T] || H <- L, T <- permute(L -- [H])].

total_distance(Points, Arrangement) ->
    lists:sum([manhattan_distance([P], [A]) || {P, A} <- lists:zip(Points, Arrangement)]).

min_total_distance(Points, Arrangements) ->
    lists:min([total_distance(Points, A) || A <- Arrangements]).

solve(Points) ->
    Arrangements = permute(Points),
    min_total_distance(Points, Arrangements).