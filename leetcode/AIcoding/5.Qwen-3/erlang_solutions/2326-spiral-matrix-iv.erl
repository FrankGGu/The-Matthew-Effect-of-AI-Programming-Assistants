-module(spiral_matrix_iv).
-export([spiralMatrix/2]).

spiralMatrix(0, _) -> [];
spiralMatrix(_, 0) -> [];
spiralMatrix(Rows, Cols) ->
    List = lists:seq(1, Rows * Cols),
    Matrix = build_matrix(List, Rows, Cols),
    spiral_traversal(Matrix, Rows, Cols).

build_matrix([], _, _) -> [];
build_matrix(List, Rows, Cols) ->
    [lists:sublist(List, Cols) | build_matrix(lists:nthtail(Cols, List), Rows, Cols)].

spiral_traversal(Matrix, Rows, Cols) ->
    spiral_traversal(Matrix, Rows, Cols, 0, 0, []).

spiral_traversal(_, _, _, Top, Left, Result) when Top >= Rows; Left >= Cols -> lists:reverse(Result);
spiral_traversal(Matrix, Rows, Cols, Top, Left, Result) ->
    % Traverse from left to right
    NewResult = traverse_left_to_right(Matrix, Top, Left, Cols - Left, []),
    spiral_traversal(Matrix, Rows, Cols, Top + 1, Left, NewResult).

traverse_left_to_right(_, _, _, 0, Acc) -> Acc;
traverse_left_to_right(Matrix, Row, Col, Count, Acc) ->
    [H | T] = lists:nth(Row + 1, Matrix),
    traverse_left_to_right(Matrix, Row, Col + 1, Count - 1, [H | Acc]).

spiral_traversal(_, _, _, Top, Left, Result) when Top >= Rows; Left >= Cols -> lists:reverse(Result);
spiral_traversal(Matrix, Rows, Cols, Top, Left, Result) ->
    % Traverse from top to bottom
    NewResult = traverse_top_to_bottom(Matrix, Top, Left, Rows - Top, []),
    spiral_traversal(Matrix, Rows, Cols, Top, Left + 1, NewResult).

traverse_top_to_bottom(_, _, _, 0, Acc) -> Acc;
traverse_top_to_bottom(Matrix, Row, Col, Count, Acc) ->
    [H | T] = lists:nth(Row + 1, Matrix),
    traverse_top_to_bottom(Matrix, Row + 1, Col, Count - 1, [H | Acc]).

spiral_traversal(_, _, _, Top, Left, Result) when Top >= Rows; Left >= Cols -> lists:reverse(Result);
spiral_traversal(Matrix, Rows, Cols, Top, Left, Result) ->
    % Traverse from right to left
    NewResult = traverse_right_to_left(Matrix, Top, Cols - 1, Cols - Left, []),
    spiral_traversal(Matrix, Rows, Cols, Top + 1, Left, NewResult).

traverse_right_to_left(_, _, _, 0, Acc) -> Acc;
traverse_right_to_left(Matrix, Row, Col, Count, Acc) ->
    [H | T] = lists:nth(Row + 1, Matrix),
    traverse_right_to_left(Matrix, Row, Col - 1, Count - 1, [H | Acc]).

spiral_traversal(_, _, _, Top, Left, Result) when Top >= Rows; Left >= Cols -> lists:reverse(Result);
spiral_traversal(Matrix, Rows, Cols, Top, Left, Result) ->
    % Traverse from bottom to top
    NewResult = traverse_bottom_to_top(Matrix, Rows - 1, Left, Rows - Top, []),
    spiral_traversal(Matrix, Rows, Cols, Top, Left + 1, NewResult).

traverse_bottom_to_top(_, _, _, 0, Acc) -> Acc;
traverse_bottom_to_top(Matrix, Row, Col, Count, Acc) ->
    [H | T] = lists:nth(Row + 1, Matrix),
    traverse_bottom_to_top(Matrix, Row - 1, Col, Count - 1, [H | Acc]).