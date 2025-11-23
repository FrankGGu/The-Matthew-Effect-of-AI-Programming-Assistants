-module(solution).
-export([check_knight_tour/1]).

check_knight_tour(Board) ->
    Size = length(Board),
    check_tour(Board, Size, 0, 0, 0).

check_tour(Board, Size, Row, Col, MoveCount) when MoveCount == Size * Size ->
    true;
check_tour(Board, Size, Row, Col, MoveCount) ->
    if
        valid_move(Board, Size, Row, Col) ->
            NewMoveCount = MoveCount + 1,
            check_tour(Board, Size, Row + 2, Col + 1, NewMoveCount) orelse
            check_tour(Board, Size, Row + 2, Col - 1, NewMoveCount) orelse
            check_tour(Board, Size, Row - 2, Col + 1, NewMoveCount) orelse
            check_tour(Board, Size, Row - 2, Col - 1, NewMoveCount) orelse
            check_tour(Board, Size, Row + 1, Col + 2, NewMoveCount) orelse
            check_tour(Board, Size, Row + 1, Col - 2, NewMoveCount) orelse
            check_tour(Board, Size, Row - 1, Col + 2, NewMoveCount) orelse
            check_tour(Board, Size, Row - 1, Col - 2, NewMoveCount);
        true -> false
    end.

valid_move(Board, Size, Row, Col) ->
    Row >= 0 andalso Row < Size andalso Col >= 0 andalso Col < Size andalso
    (lists:nth(Row + 1, Board) =:= lists:nth(Col + 1, lists:nth(Row + 1, Board))).