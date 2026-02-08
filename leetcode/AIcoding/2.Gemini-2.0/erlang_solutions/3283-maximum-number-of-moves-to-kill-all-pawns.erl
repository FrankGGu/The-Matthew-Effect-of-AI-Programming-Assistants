-module(solution).
-export([max_moves/2]).

max_moves(Pawn, Opponent) ->
    max_moves(Pawn, Opponent, 0).

max_moves([], _, Moves) ->
    Moves;
max_moves(_, [], Moves) ->
    Moves;
max_moves([PawnHead | PawnTail], [OpponentHead | OpponentTail], Moves) ->
    case PawnHead of
        X when X > OpponentHead ->
            max_moves([PawnHead | PawnTail], OpponentTail, Moves);
        _ ->
            max_moves(PawnTail, OpponentTail, Moves + 1)
    end.