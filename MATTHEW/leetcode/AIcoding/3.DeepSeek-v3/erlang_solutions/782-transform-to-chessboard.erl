-spec moves_to_chessboard(Board :: [[integer()]]) -> integer().
moves_to_chessboard(Board) ->
    N = length(Board),
    case validate_board(Board, N) of
        false -> -1;
        true ->
            Row = lists:nth(1, Board),
            Col = [lists:nth(1, lists:nth(I, Board)) || I <- lists:seq(1, N)],
            Row1 = count_swaps(Row, N),
            Col1 = count_swaps(Col, N),
            min(Row1, Col1)
    end.

validate_board(Board, N) ->
    Row1 = lists:nth(1, Board),
    Row2 = [1 - X || X <- Row1],
    CountRow1 = count_matching_rows(Board, Row1),
    CountRow2 = count_matching_rows(Board, Row2),
    if
        CountRow1 + CountRow2 =/= N -> false;
        abs(CountRow1 - CountRow2) > 1 -> false;
        true ->
            Col1 = [lists:nth(1, lists:nth(I, Board)) || I <- lists:seq(1, N)],
            Col2 = [1 - X || X <- Col1],
            CountCol1 = count_matching_cols(Board, Col1, 1),
            CountCol2 = count_matching_cols(Board, Col2, 1),
            if
                CountCol1 + CountCol2 =/= N -> false;
                abs(CountCol1 - CountCol2) > 1 -> false;
                true -> true
            end
    end.

count_matching_rows(Board, Pattern) ->
    lists:foldl(fun(Row, Acc) ->
        case Row =:= Pattern of
            true -> Acc + 1;
            false -> Acc
        end
    end, 0, Board).

count_matching_cols(Board, Pattern, J) ->
    lists:foldl(fun(Row, Acc) ->
        case lists:nth(J, Row) =:= lists:nth(J, Pattern) of
            true -> Acc + 1;
            false -> Acc
        end
    end, 0, Board).

count_swaps(Row, N) ->
    Count1 = count_alternating(Row, 0, N),
    Count2 = count_alternating(Row, 1, N),
    if
        Count1 rem 2 =:= 1, Count2 rem 2 =:= 1 -> infinity;
        Count1 rem 2 =:= 1 -> Count2 div 2;
        Count2 rem 2 =:= 1 -> Count1 div 2;
        true -> min(Count1 div 2, Count2 div 2)
    end.

count_alternating(Row, Start, N) ->
    lists:foldl(fun(I, Acc) ->
        Expected = (Start + I) rem 2,
        Actual = lists:nth(I + 1, Row),
        if
            Expected =:= Actual -> Acc;
            true -> Acc + 1
        end
    end, 0, lists:seq(0, N - 1)).