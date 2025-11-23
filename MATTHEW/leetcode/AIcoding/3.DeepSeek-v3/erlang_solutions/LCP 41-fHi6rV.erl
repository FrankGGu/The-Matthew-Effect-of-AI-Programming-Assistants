-module(solution).
-export([flipChess/1]).

flipChess(Chessboard) ->
    Rows = length(Chessboard),
    Cols = length(hd(Chessboard)),
    Directions = [{-1, -1}, {-1, 0}, {-1, 1}, {0, -1}, {0, 1}, {1, -1}, {1, 0}, {1, 1}],
    MaxFlips = lists:max([count_flips(Chessboard, Rows, Cols, I, J, Directions) || I <- lists:seq(0, Rows-1), J <- lists:seq(0, Cols-1), lists:nth(I+1, lists:nth(J+1, Chessboard)) == '.']),
    MaxFlips.

count_flips(Chessboard, Rows, Cols, X, Y, Directions) ->
    Board = [lists:map(fun(Row) -> lists:map(fun(C) -> C end, Row) end, Chessboard],
    Board1 = set_pos(Board, X, Y, 'X'),
    queue:foldl(fun(_, Acc) -> Acc + flip_in_direction(Board1, Rows, Cols, X, Y, Dir) end, 0, Directions).

flip_in_direction(Board, Rows, Cols, X, Y, {Dx, Dy}) ->
    NX = X + Dx,
    NY = Y + Dy,
    case (NX >= 0) and (NX < Rows) and (NY >= 0) and (NY < Cols) of
        false -> 0;
        true ->
            case get_pos(Board, NX, NY) of
                'O' ->
                    case search_end(Board, Rows, Cols, NX, NY, Dx, Dy) of
                        {ok, EndX, EndY} ->
                            flip_line(Board, NX, NY, EndX, EndY, Dx, Dy);
                        _ -> 0
                    end;
                _ -> 0
            end
    end.

search_end(Board, Rows, Cols, X, Y, Dx, Dy) ->
    NX = X + Dx,
    NY = Y + Dy,
    case (NX >= 0) and (NX < Rows) and (NY >= 0) and (NY < Cols) of
        false -> none;
        true ->
            case get_pos(Board, NX, NY) of
                'O' -> search_end(Board, Rows, Cols, NX, NY, Dx, Dy);
                'X' -> {ok, X, Y};
                _ -> none
            end
    end.

flip_line(Board, StartX, StartY, EndX, EndY, Dx, Dy) ->
    if
        StartX == EndX and StartY == EndY -> 0;
        true ->
            set_pos(Board, StartX, StartY, 'X'),
            1 + flip_line(Board, StartX + Dx, StartY + Dy, EndX, EndY, Dx, Dy)
    end.

get_pos(Board, X, Y) ->
    lists:nth(Y+1, lists:nth(X+1, Board)).

set_pos(Board, X, Y, Val) ->
    Row = lists:nth(X+1, Board),
    NewRow = lists:sublist(Row, Y) ++ [Val] ++ lists:nthtail(Y+1, Row),
    lists:sublist(Board, X) ++ [NewRow] ++ lists:nthtail(X+1, Board).