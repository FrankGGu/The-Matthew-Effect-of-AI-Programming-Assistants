-module(solution).
-export([max_value/1]).

max_value(Board) ->
    Rows = length(Board),
    Cols = length(hd(Board)),
    max_value_helper(Board, Rows, Cols, 0, 0, 0).

max_value_helper(_, Rows, Cols, RooksPlaced, MaxValue, _) when RooksPlaced == 3 ->
    MaxValue;
max_value_helper(Board, Rows, Cols, RooksPlaced, MaxValue, LastRow) ->
    lists:foldl(fun(Row, Acc) ->
        lists:foldl(fun(Col, Acc2) ->
            case Row >= LastRow of
                true ->
                    Value = lists:nth(Col + 1, lists:nth(Row + 1, Board)),
                    NewMaxValue = max(Acc2, Value + max_value_helper(Board, Rows, Cols, RooksPlaced + 1, 0, Row)),
                    NewMaxValue;
                false ->
                    Acc2
            end
        end, Acc, lists:seq(0, Cols - 1))
    end, MaxValue, lists:seq(0, Rows - 1).

max(A, B) when A > B -> A;
max(_, B) -> B.