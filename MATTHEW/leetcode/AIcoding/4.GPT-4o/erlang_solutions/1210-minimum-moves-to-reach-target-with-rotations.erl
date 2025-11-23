-module(solution).
-export([minimum_moves/3]).

minimum_moves(Start, Target, MaxRotations) ->
    minimum_moves(Start, Target, MaxRotations, 0, []).

minimum_moves(Start, Target, MaxRotations, Moves, Visited) when Start == Target ->
    Moves;
minimum_moves(Start, Target, MaxRotations, Moves, Visited) when Moves > MaxRotations ->
    infinity;
minimum_moves(Start, Target, MaxRotations, Moves, Visited) ->
    NextMoves = [Next || Next <- [Start + 1, Start - 1, Start * 10 + 1, Start div 10], not lists:member(Next, Visited)],
    lists:min([minimum_moves(Next, Target, MaxRotations, Moves + 1, [Start | Visited]) || Next <- NextMoves]).