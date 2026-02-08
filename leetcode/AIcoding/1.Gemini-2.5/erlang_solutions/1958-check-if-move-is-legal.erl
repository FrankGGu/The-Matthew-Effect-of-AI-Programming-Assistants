-module(solution).
-export([check_move/4]).

get_char(Board, R, C) when R >= 0, R < 8, C >= 0, C < 8 ->
    lists:nth(C + 1, lists:nth(R + 1, Board));
get_char(_Board, _R, _C) ->
    '.'.

check_line(Board, R, C, DR, DC, Color, OpponentColor, HasOpponentPiece) ->
    CurrentChar = get_char(Board, R, C),
    case CurrentChar of
        '.' -> false;
        Color -> HasOpponentPiece;
        OpponentColor ->
            check_line(Board, R + DR, C + DC, DR, DC, Color, OpponentColor, true)
    end.

check_move(Board, RMove, CMove, Color) ->
    TargetChar = get_char(Board, RMove, CMove),
    if TargetChar /= $. ->
        false;
    true ->
        OpponentColor = if Color == 'W' then 'B' else 'W' end,
        Directions = [
            {-1, -1}, {-1, 0}, {-1, 1},
            {0, -1},           {0, 1},
            {1, -1}, {1, 0}, {1, 1}
        ],
        lists:any(
            fun({DR, DC}) ->
                check_line(Board, RMove + DR, CMove + DC, DR, DC, Color, OpponentColor, false)
            end,
            Directions
        )
    end.