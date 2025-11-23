-module(rook_captures).
-export([num_rook_captures/1]).

num_rook_captures(Board) ->
    {RookRow, RookCol} = find_rook(Board),
    up(Board, RookRow, RookCol, 0) +
    down(Board, RookRow, RookCol, 0) +
    left(Board, RookRow, RookCol, 0) +
    right(Board, RookRow, RookCol, 0).

find_rook(Board) ->
    find_rook_helper(Board, 0, 0).

find_rook_helper([], _, _) ->
    undefined;
find_rook_helper([Row | Rest], RowIndex, _) ->
    case find_rook_in_row(Row, 0) of
        undefined ->
            find_rook_helper(Rest, RowIndex + 1, _);
        ColIndex ->
            {RowIndex, ColIndex}
    end;

find_rook_in_row([], _) ->
    undefined;
find_rook_in_row([$R | _], ColIndex) ->
    ColIndex;
find_rook_in_row([_ | Rest], ColIndex) ->
    find_rook_in_row(Rest, ColIndex + 1).

up(Board, Row, Col, Count) ->
    case Row of
        -1 ->
            Count;
        _ ->
            case lists:nth(Row + 1, Board) of
                RowList ->
                    case lists:nth(Col + 1, RowList) of
                        $. ->
                            up(Board, Row - 1, Col, Count);
                        $p ->
                            Count + 1;
                        $B ->
                            Count
                    end
            end
    end.

down(Board, Row, Col, Count) ->
    case Row of
        7 ->
            Count;
        _ ->
            case lists:nth(Row + 1, Board) of
                RowList ->
                    case lists:nth(Col + 1, RowList) of
                        $. ->
                            down(Board, Row + 1, Col, Count);
                        $p ->
                            Count + 1;
                        $B ->
                            Count
                    end
            end
    end.

left(Board, Row, Col, Count) ->
    case Col of
        -1 ->
            Count;
        _ ->
            case lists:nth(Row + 1, Board) of
                RowList ->
                    case lists:nth(Col + 1, RowList) of
                        $. ->
                            left(Board, Row, Col - 1, Count);
                        $p ->
                            Count + 1;
                        $B ->
                            Count
                    end
            end
    end.

right(Board, Row, Col, Count) ->
    case Col of
        7 ->
            Count;
        _ ->
            case lists:nth(Row + 1, Board) of
                RowList ->
                    case lists:nth(Col + 1, RowList) of
                        $. ->
                            right(Board, Row, Col + 1, Count);
                        $p ->
                            Count + 1;
                        $B ->
                            Count
                    end
            end
    end.