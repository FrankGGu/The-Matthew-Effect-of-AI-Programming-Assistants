-spec num_magic_squares_inside(Grid :: [[integer()]]) -> integer().
num_magic_squares_inside(Grid) ->
    Rows = length(Grid),
    if Rows < 3 -> 0;
       true ->
           Cols = length(hd(Grid)),
           if Cols < 3 -> 0;
              true ->
                  count_magic_squares(Grid, Rows, Cols, 0)
           end
    end.

count_magic_squares(Grid, Rows, Cols, Count) ->
    if Rows < 3 -> Count;
       true ->
           count_magic_squares(Grid, Rows - 1, Cols, 
               count_magic_squares_row(Grid, Rows - 1, Cols, Count))
    end.

count_magic_squares_row(Grid, Row, Cols, Count) ->
    if Cols < 3 -> Count;
       true ->
           case is_magic_square(Grid, Row, Cols - 1) of
               true -> count_magic_squares_row(Grid, Row, Cols - 1, Count + 1);
               false -> count_magic_squares_row(Grid, Row, Cols - 1, Count)
           end
    end.

is_magic_square(Grid, Row, Col) ->
    R1 = lists:nth(Row, Grid),
    R2 = lists:nth(Row + 1, Grid),
    R3 = lists:nth(Row + 2, Grid),
    A = lists:nth(Col, R1),
    B = lists:nth(Col + 1, R1),
    C = lists:nth(Col + 2, R1),
    D = lists:nth(Col, R2),
    E = lists:nth(Col + 1, R2),
    F = lists:nth(Col + 2, R2),
    G = lists:nth(Col, R3),
    H = lists:nth(Col + 1, R3),
    I = lists:nth(Col + 2, R3),
    Distinct = lists:usort([A, B, C, D, E, F, G, H, I]),
    case length(Distinct) of
        9 ->
            case lists:all(fun(X) -> X >= 1 andalso X =< 9 end, Distinct) of
                true ->
                    Sum = A + B + C,
                    Sum =:= D + E + F andalso
                    Sum =:= G + H + I andalso
                    Sum =:= A + D + G andalso
                    Sum =:= B + E + H andalso
                    Sum =:= C + F + I andalso
                    Sum =:= A + E + I andalso
                    Sum =:= C + E + G;
                false -> false
            end;
        _ -> false
    end.