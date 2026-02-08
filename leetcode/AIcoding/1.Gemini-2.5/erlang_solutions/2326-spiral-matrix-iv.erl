-module(solution).
-export([spiral_matrix_iv/3]).

-record(list_node, {val, next}).

spiral_matrix_iv(M, N, Head) ->
    % Initialize the matrix with -1
    Matrix = lists:duplicate(M, lists:duplicate(N, -1)),

    % Initial boundaries
    Top = 0,
    Bottom = M - 1,
    Left = 0,
    Right = N - 1,

    % Call a helper function to fill the matrix
    fill_spiral(Matrix, Head, Top, Bottom, Left, Right).

fill_spiral(Matrix, CurrentNode, Top, Bottom, Left, Right) ->
    % Base case: if boundaries cross or no more cells to fill
    if
        Top > Bottom; Left > Right ->
            Matrix;
        true ->
            % 1. Traverse right
            {NewMatrix1, NextNode1} = fill_right(Matrix, CurrentNode, Top, Left, Right),

            % Update Top boundary
            NewTop = Top + 1,

            % 2. Traverse down (only if there are rows left)
            {NewMatrix2, NextNode2} = 
                if NewTop <= Bottom ->
                    fill_down(NewMatrix1, NextNode1, NewTop, Bottom, Right);
                true ->
                    {NewMatrix1, NextNode1}
                end,

            % Update Right boundary
            NewRight = Right - 1,

            % 3. Traverse left (only if there are rows and columns left)
            {NewMatrix3, NextNode3} = 
                if NewTop <= Bottom andalso Left <= NewRight ->
                    fill_left(NewMatrix2, NextNode2, Bottom, NewRight, Left);
                true ->
                    {NewMatrix2, NextNode2}
                end,

            % Update Bottom boundary
            NewBottom = Bottom - 1,

            % 4. Traverse up (only if there are columns and rows left)
            {NewMatrix4, NextNode4} = 
                if Left <= NewRight andalso NewTop <= NewBottom ->
                    fill_up(NewMatrix3, NextNode3, NewBottom, NewTop, Left);
                true ->
                    {NewMatrix3, NextNode3}
                end,

            % Update Left boundary
            NewLeft = Left + 1,

            % Recurse for the inner spiral
            fill_spiral(NewMatrix4, NextNode4, NewTop, NewBottom, NewLeft, NewRight)
    end.

update_cell(Matrix, Row, Col, Val) ->
    RowList = lists:nth(Row + 1, Matrix),
    NewRowList = lists:replace_at(Col + 1, Val, RowList),
    lists:replace_at(Row + 1, NewRowList, Matrix).

fill_right(Matrix, CurrentNode, Row, Left, Right) ->
    fill_right_loop(Matrix, CurrentNode, Row, Left, Right, Left).

fill_right_loop(Matrix, CurrentNode, Row, _Left, Right, CurrentCol) ->
    if
        CurrentCol > Right ->
            {Matrix, CurrentNode};
        true ->
            {Val, NextNode} = get_node_val(CurrentNode),
            NewMatrix = update_cell(Matrix, Row, CurrentCol, Val),
            fill_right_loop(NewMatrix, NextNode, Row, _Left, Right, CurrentCol + 1)
    end.

fill_down(Matrix, CurrentNode, Top, Bottom, Col) ->
    fill_down_loop(Matrix, CurrentNode, Top, Bottom, Col, Top).

fill_down_loop(Matrix, CurrentNode, Top, Bottom, Col, CurrentRow) ->
    if
        CurrentRow > Bottom ->
            {Matrix, CurrentNode};
        true ->
            {Val, NextNode} = get_node_val(CurrentNode),
            NewMatrix = update_cell(Matrix, CurrentRow, Col, Val),
            fill_down_loop(NewMatrix, NextNode, Top, Bottom, Col, CurrentRow + 1)
    end.

fill_left(Matrix, CurrentNode, Row, Right, Left) ->
    fill_left_loop(Matrix, CurrentNode, Row, Right, Left, Right).

fill_left_loop(Matrix, CurrentNode, Row, Right, _Left, CurrentCol) ->
    if
        CurrentCol < _Left ->
            {Matrix, CurrentNode};
        true ->
            {Val, NextNode} = get_node_val(CurrentNode),
            NewMatrix = update_cell(Matrix, Row, CurrentCol, Val),
            fill_left_loop(NewMatrix, NextNode, Row, Right, _Left, CurrentCol - 1)
    end.

fill_up(Matrix, CurrentNode, Bottom, Top, Col) ->
    fill_up_loop(Matrix, CurrentNode, Bottom, Top, Col, Bottom).

fill_up_loop(Matrix, CurrentNode, Bottom, Top, Col, CurrentRow) ->
    if
        CurrentRow < Top ->
            {Matrix, CurrentNode};
        true ->
            {Val, NextNode} = get_node_val(CurrentNode),
            NewMatrix = update_cell(Matrix, CurrentRow, Col, Val),
            fill_up_loop(NewMatrix, NextNode, Bottom, Top, Col, CurrentRow - 1)
    end.

get_node_val(nil) ->
    {-1, nil};
get_node_val(#list_node{val = Val, next = Next}) ->
    {Val, Next}.