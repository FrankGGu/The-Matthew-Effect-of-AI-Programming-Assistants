-module(odd_cells).
-export([oddCells/2]).

oddCells(R, C) ->
    Matrix = lists:duplicate(R, lists:duplicate(C, 0)),
    Rows = lists:seq(1, R),
    Cols = lists:seq(1, C),
    {_, Result} = lists:foldl(fun(_Row, {MatrixAcc, Count}) ->
        {_, NewMatrix} = lists:foldl(fun(_Col, {MatrixAcc2, _}) ->
            {MatrixAcc2, lists:map(fun(Row) -> 
                lists:map(fun(Cell) -> if Cell == _Col -> Cell + 1; true -> Cell end end, Row)
            end, MatrixAcc)}
        end, {MatrixAcc, 0}, Cols),
        {NewMatrix, Count}
    end, {Matrix, 0}, Rows),
    Count = lists:foldl(fun(Row, Acc) ->
        lists:foldl(fun(Cell, Acc2) ->
            if Cell rem 2 == 1 -> Acc2 + 1; true -> Acc2 end
        end, Acc, Row)
    end, 0, Result),
    Count.