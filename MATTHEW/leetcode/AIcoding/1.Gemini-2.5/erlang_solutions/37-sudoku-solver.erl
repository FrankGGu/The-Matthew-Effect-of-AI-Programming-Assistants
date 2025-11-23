-module(sudoku_solver).
-export([solveSudoku/1]).

solveSudoku(Board) ->
    solve(Board, 0, 0).

solve(Board, 9, _) ->
    Board;
solve(Board, Row, 9) ->
    solve(Board, Row + 1, 0);
solve(Board, Row, Col) ->
    CurrentRowList = lists:nth(Row + 1, Board),
    CurrentChar = lists:nth(Col + 1, CurrentRowList),

    if CurrentChar /= $. ->
        solve(Board, Row, Col + 1);
    true ->
        try_numbers(Board, Row, Col, $1)
    end.

try_numbers(Board, Row, Col, $:) ->
    false;
try_numbers(Board, Row, Col, NumChar) ->
    if is_valid(Board, Row, Col, NumChar) ->
        UpdatedRowList = lists:replace_nth(Col + 1, NumChar, lists:nth(Row + 1, Board)),
        NewBoard = lists:replace_nth(Row + 1, UpdatedRowList, Board),
        Result = solve(NewBoard, Row, Col + 1),
        if Result /= false ->
            Result;
        true ->
            try_numbers(Board, Row, Col, NumChar + 1)
        end;
    true ->
        try_numbers(Board, Row, Col, NumChar + 1)
    end.

is_valid(Board, R, C, Char) ->
    RowList = lists:nth(R + 1, Board),
    not lists:member(Char, RowList) andalso
    (fun() ->
        ColList = [lists:nth(C + 1, lists:nth(I + 1, Board)) || I <- lists:seq(0, 8)],
        not lists:member(Char, ColList)
    end)() andalso
    (fun() ->
        StartRow = (R div 3) * 3,
        StartCol = (C div 3) * 3,
        BoxCells = [lists:nth(ColIdx + 1, lists:nth(RowIdx + 1, Board)) ||
                    RowIdx <- lists:seq(StartRow, StartRow + 2),
                    ColIdx <- lists:seq(StartCol, StartCol + 2)],
        not lists:member(Char, BoxCells)
    end)().