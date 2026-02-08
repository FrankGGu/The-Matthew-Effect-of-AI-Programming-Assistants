%% Definition for Sudoku board
%% -record(board, {row = [integer()], col = [integer()]}).

-spec solve_sudoku(Board :: [list()]) -> ok.
solve_sudoku(Board) ->
    solve_sudoku(Board, 0, 0).

solve_sudoku(Board, 9, _) -> ok;
solve_sudoku(Board, _, 9) -> solve_sudoku(Board, _, 0);
solve_sudoku(Board, Row, Col) when element(Row, Board) =:= '.' ->
    solve_sudoku(Board, Row + 1, Col + 1);
solve_sudoku(Board, Row, Col) -> ok.
