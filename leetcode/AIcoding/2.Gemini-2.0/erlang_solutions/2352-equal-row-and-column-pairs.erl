-module(equal_row_column_pairs).
-export([equal_pairs/1]).

equal_pairs(Grid) ->
    N = length(Grid),
    equal_pairs_helper(Grid, N, 0, 0, 0).

equal_pairs_helper(_Grid, N, Row, _Col, Count) when Row >= N ->
    Count;
equal_pairs_helper(Grid, N, Row, Col, Count) when Col >= N ->
    equal_pairs_helper(Grid, N, Row + 1, 0, Count);
equal_pairs_helper(Grid, N, Row, Col, Count) ->
    if row_equal_column(Grid, N, Row, Col) ->
        equal_pairs_helper(Grid, N, Row, Col + 1, Count + 1);
    else
        equal_pairs_helper(Grid, N, Row, Col + 1, Count)
    end.

row_equal_column(Grid, N, Row, Col) ->
    row_equal_column_helper(Grid, N, Row, Col, 0).

row_equal_column_helper(Grid, N, Row, Col, I) when I >= N ->
    true;
row_equal_column_helper(Grid, N, Row, Col, I) ->
    if lists:nth(I + 1, lists:nth(Row + 1, Grid)) =:= lists:nth(Row + 1, lists:nth(Col + 1, transpose(Grid))) then
        row_equal_column_helper(Grid, N, Row, Col, I + 1);
    else
        false
    end.

transpose(Grid) ->
    transpose_helper(Grid, length(lists:nth(1,Grid)), 0, []).

transpose_helper(_Grid, N, I, Acc) when I >= N ->
    Acc;
transpose_helper(Grid, N, I, Acc) ->
    transpose_helper(Grid, N, I + 1, Acc ++ [get_column(Grid, I)]).

get_column(Grid, ColIndex) ->
    get_column_helper(Grid, ColIndex, 0, []).

get_column_helper([], _ColIndex, _RowIndex, Acc) ->
    lists:reverse(Acc);
get_column_helper([Row | Rest], ColIndex, RowIndex, Acc) ->
    get_column_helper(Rest, ColIndex, RowIndex + 1, [lists:nth(ColIndex + 1, Row) | Acc]).