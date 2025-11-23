-spec num_rook_captures(Board :: [[char()]]) -> integer().
num_rook_captures(Board) ->
    {Ri, Rj} = find_rook(Board),
    lists:sum([
        check_direction(Board, Ri, Rj, -1, 0),
        check_direction(Board, Ri, Rj, 1, 0),
        check_direction(Board, Ri, Rj, 0, -1),
        check_direction(Board, Ri, Rj, 0, 1)
    ]).

find_rook(Board) ->
    find_rook(Board, 0).

find_rook([Row | Rest], I) ->
    case lists:member($R, Row) of
        true -> {I, find_col(Row, 0)};
        false -> find_rook(Rest, I + 1)
    end.

find_col([$R | _], J) -> J;
find_col([_ | Rest], J) -> find_col(Rest, J + 1).

check_direction(Board, Ri, Rj, Di, Dj) ->
    check_direction(Board, Ri + Di, Rj + Dj, Di, Dj).

check_direction(Board, I, J, Di, Dj) ->
    case (I >= 0) and (I < 8) and (J >= 0) and (J < 8) of
        true ->
            case lists:nth(I + 1, Board) of
                Row ->
                    case lists:nth(J + 1, Row) of
                        $p -> 1;
                        $B -> 0;
                        _ -> check_direction(Board, I + Di, J + Dj, Di, Dj)
                    end
            end;
        false -> 0
    end.