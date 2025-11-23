-module(solution).
-export([tictactoe/1]).

tictactoe(Moves) ->
    make_moves_recursive(Moves, [[0,0,0],[0,0,0],[0,0,0]], 0).

make_moves_recursive([], _Board, MoveCount) ->
    case MoveCount of
        9 -> "Draw";
        _ -> "Pending"
    end;
make_moves_recursive([[R, C] | RestMoves], Board, MoveCount) ->
    PlayerMark = case MoveCount rem 2 of
                     0 -> 1;
                     _ -> -1
                 end,
    NewBoard = update_board(Board, R, C, PlayerMark),
    case check_winner(NewBoard) of
        "A" -> "A";
        "B" -> "B";
        no_winner ->
            make_moves_recursive(RestMoves, NewBoard, MoveCount + 1)
    end.

update_board(Board, R, C, Mark) ->
    lists:replace_at(R + 1, lists:replace_at(C + 1, Mark, lists:nth(R + 1, Board)), Board).

check_winner(Board) ->
    case check_rows(Board) of
        "A" -> "A";
        "B" -> "B";
        no_winner ->
            TransposedBoard = transpose(Board),
            case check_rows(TransposedBoard) of
                "A" -> "A";
                "B" -> "B";
                no_winner ->
                    case check_diagonals(Board) of
                        "A" -> "A";
                        "B" -> "B";
                        no_winner -> no_winner
                    end
            end
    end.

check_rows([]) -> no_winner;
check_rows([Row | RestRows]) ->
    Sum = lists:sum(Row),
    case Sum of
        3 -> "A";
        -3 -> "B";
        _ -> check_rows(RestRows)
    end.

transpose([[A1,B1,C1],[A2,B2,C2],[A3,B3,C3]]) ->
    [[A1,A2,A3],[B1,B2,B3],[C1,C2,C3]].

check_diagonals(Board) ->
    [R0, R1, R2] = Board,
    [C00, _, C02] = R0,
    [_, C11, _] = R1,
    [C20, _, C22] = R2,

    SumDiag1 = C00 + C11 + C22,
    case SumDiag1 of
        3 -> "A";
        -3 -> "B";
        _ ->
            SumDiag2 = C02 + C11 + C20,
            case SumDiag2 of
                3 -> "A";
                -3 -> "B";
                _ -> no_winner
            end
    end.