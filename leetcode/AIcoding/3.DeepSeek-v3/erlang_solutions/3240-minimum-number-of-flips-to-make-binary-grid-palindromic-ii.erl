-spec min_flips(Grid :: [[char()]]) -> integer().
min_flips(Grid) ->
    N = length(Grid),
    M = length(hd(Grid)),
    Flips = 0,
    min_flips(Grid, N, M, 0, N - 1, 0, M - 1, Flips).

min_flips(_Grid, _N, _M, I1, I2, _J1, _J2, Flips) when I1 >= I2 ->
    Flips;
min_flips(Grid, N, M, I1, I2, J1, J2, Flips) ->
    {NewFlips, NewJ1, NewJ2} = check_row(Grid, I1, I2, J1, J2, Flips),
    min_flips(Grid, N, M, I1 + 1, I2 - 1, NewJ1, NewJ2, NewFlips).

check_row(Grid, I1, I2, J1, J2, Flips) ->
    check_row(Grid, I1, I2, J1, J2, Flips, J1, J2).

check_row(_Grid, _I1, _I2, J1, J2, Flips, CurrJ1, CurrJ2) when CurrJ1 >= CurrJ2 ->
    {Flips, J1 + 1, J2 - 1};
check_row(Grid, I1, I2, J1, J2, Flips, CurrJ1, CurrJ2) ->
    Pos1 = {I1, CurrJ1},
    Pos2 = {I1, CurrJ2},
    Pos3 = {I2, CurrJ1},
    Pos4 = {I2, CurrJ2},
    V1 = get_value(Grid, Pos1),
    V2 = get_value(Grid, Pos2),
    V3 = get_value(Grid, Pos3),
    V4 = get_value(Grid, Pos4),
    Sum = V1 + V2 + V3 + V4,
    case Sum of
        0 -> check_row(Grid, I1, I2, J1, J2, Flips, CurrJ1 + 1, CurrJ2 - 1);
        4 -> check_row(Grid, I1, I2, J1, J2, Flips, CurrJ1 + 1, CurrJ2 - 1);
        1 -> {Flips + 1, J1 + 1, J2 - 1};
        3 -> {Flips + 1, J1 + 1, J2 - 1};
        2 ->
            case (V1 == V2) or (V1 == V3) of
                true -> {Flips + 2, J1 + 1, J2 - 1};
                false -> check_row(Grid, I1, I2, J1, J2, Flips + 1, CurrJ1 + 1, CurrJ2 - 1)
            end
    end.

get_value(Grid, {I, J}) ->
    Row = lists:nth(I + 1, Grid),
    case lists:nth(J + 1, Row) of
        $0 -> 0;
        $1 -> 1
    end.