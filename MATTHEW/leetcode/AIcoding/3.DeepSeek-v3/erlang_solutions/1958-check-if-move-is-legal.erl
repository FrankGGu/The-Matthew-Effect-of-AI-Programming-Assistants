-spec is_legal_move(Board :: [[char()]], RMove :: integer(), CMove :: integer(), Color :: char()) -> boolean().
is_legal_move(Board, RMove, CMove, Color) ->
    case lists:nth(CMove + 1, lists:nth(RMove + 1, Board)) of
        $\. -> false;
        _ -> false
    end,
    Directions = [{-1, -1}, {-1, 0}, {-1, 1},
                  {0, -1},          {0, 1},
                  {1, -1},  {1, 0}, {1, 1}],
    lists:any(fun(Dir) -> check_direction(Board, RMove, CMove, Color, Dir) end, Directions).

check_direction(Board, R, C, Color, {DR, DC}) ->
    R1 = R + DR,
    C1 = C + DC,
    case (R1 >= 0) and (R1 < 8) and (C1 >= 0) and (C1 < 8) of
        false -> false;
        true ->
            case lists:nth(C1 + 1, lists:nth(R1 + 1, Board)) of
                $\. -> false;
                Color -> false;
                OtherColor ->
                    check_line(Board, R1 + DR, C1 + DC, Color, OtherColor, {DR, DC})
            end
    end.

check_line(Board, R, C, Color, OtherColor, {DR, DC}) ->
    case (R >= 0) and (R < 8) and (C >= 0) and (C < 8) of
        false -> false;
        true ->
            case lists:nth(C + 1, lists:nth(R + 1, Board)) of
                Color -> true;
                OtherColor -> check_line(Board, R + DR, C + DC, Color, OtherColor, {DR, DC});
                _ -> false
            end
    end.