-module(solution).
-export([max_value/2]).

max_value(Grid, Rows) ->
    max_value(Grid, Rows, 0, 0, []).

max_value([], _, _, _, Acc) ->
    lists:last(Acc);
max_value([Row | Rest], Rows, Col, RowIdx, Acc) when RowIdx == Rows - 1 ->
    NewAcc = [lists:sum(Row) | Acc],
    max_value(Rest, Rows, Col + 1, RowIdx, NewAcc);
max_value([Row | Rest], Rows, Col, RowIdx, Acc) ->
    Current = lists:nth(Col + 1, Row),
    Prev = case RowIdx of
               0 -> 0;
               _ -> lists:nth(Col + 1, lists:nth(RowIdx - 1, Acc))
           end,
    NewVal = Current + Prev,
    NewAcc = [NewVal | Acc],
    max_value(Rest, Rows, Col + 1, RowIdx, NewAcc).