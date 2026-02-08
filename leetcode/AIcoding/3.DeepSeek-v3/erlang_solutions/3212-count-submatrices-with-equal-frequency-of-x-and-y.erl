-spec count_submatrices_with_equal_frequency_of_x_and_y(Matrix :: [[char()]], X :: char(), Y :: char()) -> integer().
count_submatrices_with_equal_frequency_of_x_and_y(Matrix, X, Y) ->
    Rows = length(Matrix),
    Cols = length(hd(Matrix)),
    Prefix = lists:duplicate(Rows + 1, lists:duplicate(Cols + 1, {0, 0})),
    {Prefix1, _} = lists:mapfoldl(fun(Row, {RowAcc, I}) ->
        {Row1, _} = lists:mapfoldl(fun(Val, {ColAcc, J}) ->
            {XCount, YCount} = lists:nth(J, lists:nth(I, RowAcc)),
            NewX = if Val =:= X -> XCount + 1; true -> XCount end,
            NewY = if Val =:= Y -> YCount + 1; true -> YCount end,
            Up = lists:nth(J, lists:nth(I, RowAcc)),
            Left = lists:nth(J + 1, lists:nth(I + 1, RowAcc)),
            Diag = lists:nth(J, lists:nth(I + 1, RowAcc)),
            SumX = element(1, Up) + element(1, Left) - element(1, Diag) + NewX,
            SumY = element(2, Up) + element(2, Left) - element(2, Diag) + NewY,
            NewAcc = {SumX, SumY},
            {NewAcc, {ColAcc ++ [NewAcc], J + 1}}
        end, {[], 1}, Row),
        {RowAcc ++ [Row1], I + 1}
    end, {Prefix, 1}, Matrix),
    Count = lists:foldl(fun(I, AccI) ->
        lists:foldl(fun(J, AccJ) ->
            lists:foldl(fun(K, AccK) ->
                lists:foldl(fun(L, AccL) ->
                    if
                        K =< I, L =< J ->
                            X1 = element(1, lists:nth(L, lists:nth(K, Prefix1))),
                            X2 = element(1, lists:nth(J + 1, lists:nth(K, Prefix1))),
                            X3 = element(1, lists:nth(L, lists:nth(I + 1, Prefix1))),
                            X4 = element(1, lists:nth(J + 1, lists:nth(I + 1, Prefix1))),
                            Y1 = element(2, lists:nth(L, lists:nth(K, Prefix1))),
                            Y2 = element(2, lists:nth(J + 1, lists:nth(K, Prefix1))),
                            Y3 = element(2, lists:nth(L, lists:nth(I + 1, Prefix1))),
                            Y4 = element(2, lists:nth(J + 1, lists:nth(I + 1, Prefix1))),
                            TotalX = X4 - X2 - X3 + X1,
                            TotalY = Y4 - Y2 - Y3 + Y1,
                            if TotalX =:= TotalY -> AccL + 1; true -> AccL end;
                        true -> AccL
                    end
                end, AccK, lists:seq(1, J))
            end, AccJ, lists:seq(1, I))
        end, AccI, lists:seq(1, Cols))
    end, 0, lists:seq(1, Rows)),
    Count.