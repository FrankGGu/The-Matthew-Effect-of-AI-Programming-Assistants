-module(solution).
-export([max_moves/1]).

max_moves(Board) ->
    Rows = length(Board),
    Cols = length(hd(Board)),
    max_moves(Board, 0, 0, 0, Rows, Cols).

max_moves(_, _, C, Acc, _, _) when C >= 3 ->
    Acc;
max_moves(Board, R, C, Acc, Rows, Cols) ->
    case get_pawn(Board, R, C) of
        'P' ->
            NewAcc = Acc + 1,
            NextR = R + 1,
            NextC = C + 1,
            if
                NextR < Rows andalso NextC < Cols ->
                    max_moves(Board, NextR, NextC, NewAcc, Rows, Cols);
                true ->
                    max_moves(Board, 0, C + 1, NewAcc, Rows, Cols)
            end;
        _ ->
            max_moves(Board, R, C + 1, Acc, Rows, Cols)
    end.

get_pawn(Board, R, C) ->
    lists:nth(R + 1, Board) -- [] ++ [lists:nth(C + 1, lists:nth(R + 1, Board))].