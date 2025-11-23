-module(solution).
-export([spiral_order/1]).

spiral_order(Matrix) ->
    Rows = length(Matrix),
    Cols = if Rows == 0 -> 0; true -> length(hd(Matrix)) end,
    spiral_order_impl(Matrix, 0, Rows - 1, 0, Cols - 1, []).

spiral_order_impl(_Matrix, Top, Bottom, _Left, _Right, Acc) when Top > Bottom ->
    lists:reverse(Acc);
spiral_order_impl(_Matrix, _Top, _Bottom, Left, Right, Acc) when Left > Right ->
    lists:reverse(Acc);
spiral_order_impl(Matrix, Top, Bottom, Left, Right, Acc) ->
    % 1. Traverse Left to Right (top row)
    RowTop = lists:nth(Top + 1, Matrix),
    Acc1 = lists:foldl(fun(Col, CurrentAcc) ->
                              lists:nth(Col + 1, RowTop) :: CurrentAcc
                      end, Acc, lists:seq(Left, Right)),

    NewTop = Top + 1,

    % Check if boundaries crossed after L->R
    if NewTop > Bottom ->
        lists:reverse(Acc1);
    true ->
        % 2. Traverse Top to Bottom (rightmost column)
        Acc2 = lists:foldl(fun(Row, CurrentAcc) ->
                                  RowNth = lists:nth(Row + 1, Matrix),
                                  lists:nth(Right + 1, RowNth) :: CurrentAcc
                          end, Acc1, lists:seq(NewTop, Bottom)),

        NewRight = Right - 1,

        % Check if boundaries crossed after T->B
        if Left > NewRight ->
            lists:reverse(Acc2);
        true ->
            % 3. Traverse Right to Left (bottom row)
            RowBottom = lists:nth(Bottom + 1, Matrix),
            Acc3 = lists:foldl(fun(Col, CurrentAcc) ->
                                      lists:nth(Col + 1, RowBottom) :: CurrentAcc
                              end, Acc2, lists:seq(Right, Left, -1)),

            NewBottom = Bottom - 1,

            % Check if boundaries crossed after R->L
            if NewTop > NewBottom ->
                lists:reverse(Acc3);
            true ->
                % 4. Traverse Bottom to Top (leftmost column)
                Acc4 = lists:foldl(fun(Row, CurrentAcc) ->
                                          RowNth = lists:nth(Row + 1, Matrix),
                                          lists:nth(Left + 1, RowNth) :: CurrentAcc
                                  end, Acc3, lists:seq(Bottom, NewTop, -1)),

                NewLeft = Left + 1,

                % Recurse for the inner layer
                spiral_order_impl(Matrix, NewTop, NewBottom, NewLeft, NewRight, Acc4)
            end
        end
    end.