-module(solution).
-export([minIncrementForUnique/1]).

minIncrementForUnique(A) ->
    SortedA = lists:sort(A),
    min_increment_unique_helper(SortedA, -1, 0).

min_increment_unique_helper([], _PrevUnique, AccMoves) ->
    AccMoves;
min_increment_unique_helper([H|T], PrevUnique, AccMoves) ->
    CurrentTarget = max(H, PrevUnique + 1),
    MovesForH = CurrentTarget - H,
    NewAccMoves = AccMoves + MovesForH,
    min_increment_unique_helper(T, CurrentTarget, NewAccMoves).