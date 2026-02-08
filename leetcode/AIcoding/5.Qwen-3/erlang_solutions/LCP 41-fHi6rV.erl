-module(solution).
-export([num_moves/1]).

num_moves(Board) ->
    Rows = length(Board),
    Cols = length(hd(Board)),
    Count = 0,
    move(0, Rows - 1, 0, Cols - 1, Board, Count).

move(Row, MaxRow, Col, MaxCol, Board, Count) when Row > MaxRow ->
    Count;
move(Row, MaxRow, Col, MaxCol, Board, Count) when Col > MaxCol ->
    move(Row + 1, MaxRow, 0, MaxCol, Board, Count);
move(Row, MaxRow, Col, MaxCol, Board, Count) ->
    Cell = lists:nth(Row + 1, Board),
    Value = lists:nth(Col + 1, Cell),
    if
        Value == $B ->
            move(Row, MaxRow, Col + 1, MaxCol, Board, Count);
        true ->
            NewCount = count_moves(Row, Col, Board),
            move(Row, MaxRow, Col + 1, MaxCol, Board, Count + NewCount)
    end.

count_moves(Row, Col, Board) ->
    Directions = [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]],
    count_moves(Directions, Row, Col, Board, 0).

count_moves([], _, _, _, Count) ->
    Count;
count_moves([Dir | Rest], Row, Col, Board, Count) ->
    [DRow, DCol] = Dir,
    NewRow = Row + DRow,
    NewCol = Col + DCol,
    if
        NewRow < 0 orelse NewRow >= length(Board) orelse NewCol < 0 orelse NewCol >= length(hd(Board)) ->
            count_moves(Rest, Row, Col, Board, Count);
        true ->
            Cell = lists:nth(NewRow + 1, Board),
            Value = lists:nth(NewCol + 1, Cell),
            if
                Value == $W ->
                    count_moves(Rest, Row, Col, Board, Count);
                Value == $B ->
                    count_moves(Rest, Row, Col, Board, Count);
                true ->
                    Count2 = check_line(NewRow, NewCol, DRow, DCol, Board, 0),
                    count_moves(Rest, Row, Col, Board, Count + Count2)
            end
    end.

check_line(Row, Col, DRow, DCol, Board, Count) ->
    Cell = lists:nth(Row + 1, Board),
    Value = lists:nth(Col + 1, Cell),
    if
        Value == $W ->
            Count;
        Value == $B ->
            Count;
        true ->
            NewRow = Row + DRow,
            NewCol = Col + DCol,
            if
                NewRow < 0 orelse NewRow >= length(Board) orelse NewCol < 0 orelse NewCol >= length(hd(Board)) ->
                    0;
                true ->
                    check_line(NewRow, NewCol, DRow, DCol, Board, Count + 1)
            end
    end.