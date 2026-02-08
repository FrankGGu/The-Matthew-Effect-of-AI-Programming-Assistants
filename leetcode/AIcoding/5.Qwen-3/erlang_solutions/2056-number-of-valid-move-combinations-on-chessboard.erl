-module(chessboard).
-export([find_moves/1]).

find_moves(Board) ->
    find_moves(Board, 0, 0, []).

find_moves(_, _, _, Acc) when Acc =:= [] -> 0;
find_moves(Board, Row, Col, Acc) ->
    case Board of
        [RowList | Rest] when Row < length(Board) ->
            case RowList of
                [Val | _] when Val == 1 ->
                    find_moves(Board, Row + 1, 0, Acc);
                _ ->
                    find_moves(Board, Row, Col + 1, Acc)
            end;
        _ ->
            find_moves(Board, 0, 0, [])
    end.

find_moves(Board, Row, Col, Acc) when Col < length(hd(Board)) ->
    case lists:nth(Row + 1, Board) of
        [Val | _] when Val == 1 ->
            find_moves(Board, Row, Col + 1, Acc);
        _ ->
            NewAcc = lists:append(Acc, [[Row, Col]]),
            find_moves(Board, Row, Col + 1, NewAcc)
    end;
find_moves(_, _, _, Acc) ->
    count_valid_moves(Acc).

count_valid_moves(Moves) ->
    count_valid_moves(Moves, 0).

count_valid_moves([], Count) ->
    Count;
count_valid_moves([Move | Rest], Count) ->
    count_valid_moves(Rest, Count + 1).