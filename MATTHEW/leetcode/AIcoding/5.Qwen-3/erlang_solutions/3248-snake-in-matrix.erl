-module(snake_in_matrix).
-export([snake_order/1]).

snake_order(Matrix) ->
    Rows = length(Matrix),
    if
        Rows == 0 -> [];
        true ->
            Cols = length(hd(Matrix)),
            Result = lists:seq(0, Rows - 1),
            lists:foldl(fun(Row, Acc) ->
                            RowData = lists:nth(Row + 1, Matrix),
                            if
                                Row rem 2 == 0 -> Acc ++ RowData;
                                true -> Acc ++ lists:reverse(RowData)
                            end
                        end, [], Result)
    end.