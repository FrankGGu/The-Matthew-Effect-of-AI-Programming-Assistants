-module(subrectangle_queries).
-export([new/2, update/5, get_value/3]).

-record(rectangle, {matrix}).

new(Rows, Cols) ->
    Matrix = lists:duplicate(Rows, lists:duplicate(Cols, 0)),
    #rectangle{matrix = Matrix}.

update(#rectangle{matrix = Matrix} = Rect, row1, col1, row2, col2, new_value) ->
    NewMatrix = lists:map(fun(Row, RowIndex) ->
        if RowIndex >= row1 and RowIndex =< row2 ->
            lists:map(fun(Val, ColIndex) ->
                if ColIndex >= col1 and ColIndex =< col2 ->
                    new_value;
                true -> Val
                end
            end, Row);
        true -> Row
        end
    end, Matrix, lists:seq(0, length(Matrix) - 1)),
    Rect#rectangle{matrix = NewMatrix}.

get_value(#rectangle{matrix = Matrix}, row, col) ->
    lists:nth(row + 1, Matrix) |> lists:nth(col + 1).