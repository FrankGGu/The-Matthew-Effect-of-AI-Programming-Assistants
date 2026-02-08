-module(solution).
-export([count_combinations/1]).

count_combinations(Pieces) ->
    AllPieceMoves = [get_all_moves(Type, R, C) || {Type, R, C} <- Pieces],
    backtrack(AllPieceMoves, 0, []).

backtrack(AllPieceMoves, PieceIdx, CurrentChosenMoves) when PieceIdx == length(AllPieceMoves) ->
    1;
backtrack(AllPieceMoves, PieceIdx, CurrentChosenMoves) ->
    MovesForCurrentPiece = lists:nth(PieceIdx + 1, AllPieceMoves),
    lists:foldl(fun(Move, Acc) ->
        case lists:member(Move, CurrentChosenMoves) of
            true -> Acc;
            false ->
                Acc + backtrack(AllPieceMoves, PieceIdx + 1, [Move | CurrentChosenMoves])
        end
    end, 0, MovesForCurrentPiece).

get_all_moves(<<"rook">>, R, C) ->
    get_straight_moves(R, C);
get_all_moves(<<"bishop">>, R, C) ->
    get_diagonal_moves(R, C);
get_all_moves(<<"queen">>, R, C) ->
    get_straight_moves(R, C) ++ get_diagonal_moves(R, C).

get_straight_moves(R, C) ->
    get_moves_in_direction(R, C, 0, 1) ++
    get_moves_in_direction(R, C, 0, -1) ++
    get_moves_in_direction(R, C, 1, 0) ++
    get_moves_in_direction(R, C, -1, 0).

get_diagonal_moves(R, C) ->
    get_moves_in_direction(R, C, 1, 1) ++
    get_moves_in_direction(R, C, 1, -1) ++
    get_moves_in_direction(R, C, -1, 1) ++
    get_moves_in_direction(R, C, -1, -1).

get_moves_in_direction(R, C, DR, DC) ->
    get_moves_in_direction(R, C, DR, DC, []).

get_moves_in_direction(CurR, CurC, DR, DC, Acc) ->
    NextR = CurR + DR,
    NextC = CurC + DC,
    case is_valid_square(NextR, NextC) of
        true ->
            get_moves_in_direction(NextR, NextC, DR, DC, [{NextR, NextC} | Acc]);
        false ->
            lists:reverse(Acc)
    end.

is_valid_square(R, C) ->
    R >= 1 andalso R =< 8 andalso C >= 1 andalso C =< 8.