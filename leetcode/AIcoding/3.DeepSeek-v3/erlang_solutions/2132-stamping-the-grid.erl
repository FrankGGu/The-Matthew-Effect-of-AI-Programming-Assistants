-module(solution).
-export([possible_to_stamp/3]).

possible_to_stamp(Grid, StampHeight, StampWidth) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    Sum = lists:duplicate(Rows + 1, lists:duplicate(Cols + 1, 0)),
    {Sum1, _} = lists:mapfoldl(fun(Row, {SumAcc, I}) ->
        {RowSum, _} = lists:mapfoldl(fun(Cell, {RowSumAcc, J}) ->
            Val = case Cell of 1 -> 1; 0 -> 0 end,
            NewVal = lists:nth(J, lists:nth(I, SumAcc)) + 
                    lists:nth(J + 1, lists:nth(I + 1, SumAcc)) - 
                    lists:nth(J + 1, lists:nth(I, SumAcc)) + Val,
            {[NewVal | RowSumAcc], J + 1}
        end, {[], 1}, Row),
        {[lists:reverse(RowSum) | SumAcc], I + 1}
    end, {Sum, 1}, Grid),
    Sum2 = lists:reverse(Sum1),
    Diff = lists:duplicate(Rows + 2, lists:duplicate(Cols + 2, 0)),
    {Diff1, _} = lists:foldl(fun(I, {DiffAcc, _}) ->
        lists:foldl(fun(J, {DiffRowAcc, _}) ->
            X = I + StampHeight - 1,
            Y = J + StampWidth - 1,
            if
                X > Rows; Y > Cols ->
                    {DiffRowAcc, ok};
                true ->
                    Total = lists:nth(Y, lists:nth(X, Sum2)) - 
                             lists:nth(Y, lists:nth(I, Sum2)) - 
                             lists:nth(J, lists:nth(X, Sum2)) + 
                             lists:nth(J, lists:nth(I, Sum2)),
                    if
                        Total == 0 ->
                            NewDiff = update_diff(DiffRowAcc, I, J, 1),
                            NewDiff1 = update_diff(NewDiff, I, Y + 1, -1),
                            NewDiff2 = update_diff(NewDiff1, X + 1, J, -1),
                            NewDiff3 = update_diff(NewDiff2, X + 1, Y + 1, 1),
                            {NewDiff3, ok};
                        true ->
                            {DiffRowAcc, ok}
                    end
            end
        end, {DiffAcc, ok}, lists:seq(1, Cols))
    end, {Diff, ok}, lists:seq(1, Rows)),
    {Diff2, _} = lists:mapfoldl(fun(I, {DiffAcc, _}) ->
        {RowDiff, _} = lists:mapfoldl(fun(J, {RowDiffAcc, _}) ->
            Val = lists:nth(J, lists:nth(I, DiffAcc)) + 
                  lists:nth(J, lists:nth(I + 1, DiffAcc)) + 
                  lists:nth(J + 1, lists:nth(I, DiffAcc)) - 
                  lists:nth(J + 1, lists:nth(I + 1, DiffAcc)),
            NewVal = if
                Val > 0 -> 0;
                true -> lists:nth(J, lists:nth(I, Grid))
            end,
            {[NewVal | RowDiffAcc], ok}
        end, {[], ok}, lists:seq(1, Cols)),
        {[lists:reverse(RowDiff) | DiffAcc], ok}
    end, {Diff1, ok}, lists:seq(1, Rows)),
    lists:all(fun(Row) -> lists:all(fun(Cell) -> Cell == 0 end, Row) end, tl(lists:reverse(Diff2))).

update_diff(Diff, I, J, Val) ->
    Row = lists:nth(I, Diff),
    NewVal = lists:nth(J, Row) + Val,
    NewRow = set_nth(J, NewVal, Row),
    set_nth(I, NewRow, Diff).

set_nth(1, Val, [_ | T]) -> [Val | T];
set_nth(N, Val, [H | T]) -> [H | set_nth(N - 1, Val, T)].