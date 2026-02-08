-module(check_if_move_is_legal).
-export([is_move_legal/4]).

is_move_legal(Board, Row, Col, Color) ->
    is_within_bounds(Row, Col) andalso
    Board[[Row, Col]] == "." andalso
    has_flippable_pieces(Board, Row, Col, Color).

has_flippable_pieces(Board, Row, Col, Color) ->
    check_direction(Board, Row, Col, Color, -1, -1) orelse
    check_direction(Board, Row, Col, Color, -1, 0) orelse
    check_direction(Board, Row, Col, Color, -1, 1) orelse
    check_direction(Board, Row, Col, Color, 0, -1) orelse
    check_direction(Board, Row, Col, Color, 0, 1) orelse
    check_direction(Board, Row, Col, Color, 1, -1) orelse
    check_direction(Board, Row, Col, Color, 1, 0) orelse
    check_direction(Board, Row, Col, Color, 1, 1).

check_direction(Board, Row, Col, Color, RowDir, ColDir) ->
    OppositeColor = case Color of
        "W" -> "B";
        "B" -> "W"
    end,
    check_direction_recursive(Board, Row, Col, Color, RowDir, ColDir, OppositeColor, false).

check_direction_recursive(Board, Row, Col, Color, RowDir, ColDir, OppositeColor, FoundOpposite) ->
    NextRow = Row + RowDir,
    NextCol = Col + ColDir,
    case is_within_bounds(NextRow, NextCol) of
        false -> false;
        true ->
            case Board[[NextRow, NextCol]] of
                "." -> false;
                OppositeColor ->
                    check_direction_recursive(Board, NextRow, NextCol, Color, RowDir, ColDir, OppositeColor, true);
                Color ->
                    FoundOpposite;
                _ -> false
            end
    end.

is_within_bounds(Row, Col) ->
    Row >= 0 andalso Row < 8 andalso Col >= 0 andalso Col < 8.