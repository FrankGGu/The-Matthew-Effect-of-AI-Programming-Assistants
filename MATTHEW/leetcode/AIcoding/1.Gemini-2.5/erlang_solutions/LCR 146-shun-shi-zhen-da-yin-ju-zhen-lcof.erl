-module(solution).
-export([spiral_order/1]).

spiral_order(Matrix) ->
    case Matrix of
        [] -> [];
        [[]|_] -> [];
        _ ->
            Rows = length(Matrix),
            Cols = length(hd(Matrix)),
            spiral_order_loop(Matrix, 1, Rows, 1, Cols, [])
    end.

spiral_order_loop(_Matrix, Top, Bottom, _Left, _Right, Acc) when Top > Bottom ->
    lists:reverse(Acc);
spiral_order_loop(_Matrix, _Top, _Bottom, Left, Right, Acc) when Left > Right ->
    lists:reverse(Acc);
spiral_order_loop(Matrix, Top, Bottom, Left, Right, Acc) ->
    % 1. Traverse Right
    Acc1 = traverse_right(Matrix, Top, Left, Right, Acc),
    NewTop = Top + 1,

    % Check if boundaries crossed after right traversal
    case NewTop > Bottom of
        true -> lists:reverse(Acc1);
        false ->
            % 2. Traverse Down
            Acc2 = traverse_down(Matrix, NewTop, Bottom, Right, Acc1),
            NewRight = Right - 1,

            % Check if boundaries crossed after down traversal
            case Left > NewRight of
                true -> lists:reverse(Acc2);
                false ->
                    % 3. Traverse Left
                    Acc3 = traverse_left(Matrix, Bottom, NewRight, Left, Acc2),
                    NewBottom = Bottom - 1,

                    % Check if boundaries crossed after left traversal
                    case NewTop > NewBottom of
                        true -> lists:reverse(Acc3);
                        false ->
                            % 4. Traverse Up
                            Acc4 = traverse_up(Matrix, NewBottom, NewTop, Left, Acc3),
                            NewLeft = Left + 1,

                            % Recurse for the next inner layer
                            spiral_order_loop(Matrix, NewTop, NewBottom, NewLeft, NewRight, Acc4)
                    end
            end
    end.

traverse_right(Matrix, Row, StartCol, EndCol, Acc) ->
    RowList = lists:nth(Row, Matrix),
    lists:foldl(fun(Col, CurrentAcc) ->
        [lists:nth(Col, RowList) | CurrentAcc]
    end, Acc, lists:seq(StartCol, EndCol)).

traverse_down(Matrix, StartRow, EndRow, Col, Acc) ->
    lists:foldl(fun(Row, CurrentAcc) ->
        RowList = lists:nth(Row, Matrix),
        [lists:nth(Col, RowList) | CurrentAcc]
    end, Acc, lists:seq(StartRow, EndRow)).

traverse_left(Matrix, Row, StartCol, EndCol, Acc) ->
    RowList = lists:nth(Row, Matrix),
    lists:foldl(fun(Col, CurrentAcc) ->
        [lists:nth(Col, RowList) | CurrentAcc]
    end, Acc, lists:seq(StartCol, EndCol, -1)).

traverse_up(Matrix, StartRow, EndRow, Col, Acc) ->
    lists:foldl(fun(Row, CurrentAcc) ->
        RowList = lists:nth(Row, Matrix),
        [lists:nth(Col, RowList) | CurrentAcc]
    end, Acc, lists:seq(StartRow, EndRow, -1)).