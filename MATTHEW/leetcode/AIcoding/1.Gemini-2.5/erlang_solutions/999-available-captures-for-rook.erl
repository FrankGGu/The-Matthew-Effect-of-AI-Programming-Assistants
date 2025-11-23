-module(solution).
-export([available_captures/1]).

available_captures(Board) ->
    {RRow, RCol} = find_rook(Board, 0, 0),
    check_directions(Board, RRow, RCol, 0).

find_rook(Board, Row, Col) when Row < 8 ->
    Char = get_char(Board, Row, Col),
    case Char of
        $'R' -> {Row, Col};
        _ ->
            case Col + 1 of
                8 -> find_rook(Board, Row + 1, 0);
                _ -> find_rook(Board, Row, Col + 1)
            end
    end.

check_directions(Board, RRow, RCol, Captures) ->
    Captures1 = check_direction(Board, RRow, RCol, -1, 0, Captures),
    Captures2 = check_direction(Board, RRow, RCol, 1, 0, Captures1),
    Captures3 = check_direction(Board, RRow, RCol, 0, -1, Captures2),
    Captures4 = check_direction(Board, RRow, RCol, 0, 1, Captures3),
    Captures4.

check_direction(Board, RRow, RCol, DR, DC, Captures) ->
    NewR = RRow + DR,
    NewC = RCol + DC,
    case is_valid_pos(NewR, NewC) of
        false -> Captures;
        true ->
            Char = get_char(Board, NewR, NewC),
            case Char of
                $'p' -> Captures + 1;
                $'B' -> Captures;
                $'.' -> check_direction(Board, NewR, NewC, DR, DC, Captures);
                _ -> Captures
            end
    end.

is_valid_pos(R, C) ->
    R >= 0 and R < 8 and C >= 0 and C < 8.

get_char(Board, R, C) ->
    lists:nth(C + 1, lists:nth(R + 1, Board)).