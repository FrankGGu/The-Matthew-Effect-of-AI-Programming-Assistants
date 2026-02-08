-module(solution).
-export([equal_pairs/1]).

equal_pairs(Grid) ->
    Rows = Grid,
    Columns = transpose(Grid),
    count_pairs(Rows, Columns).

transpose([]) -> [];
transpose([[]|_]) -> [];
transpose(Matrix) ->
    [lists:map(fun hd/1, Matrix) | transpose(lists:map(fun tl/1, Matrix))].

count_pairs(Rows, Columns) ->
    lists:foldl(fun(Row, Acc) ->
        Acc + count_equal_columns(Row, Columns)
    end, 0, Rows).

count_equal_columns(Row, Columns) ->
    lists:foldl(fun(Col, Acc) ->
        if Row =:= Col -> Acc + 1;
           true -> Acc
        end
    end, 0, Columns).