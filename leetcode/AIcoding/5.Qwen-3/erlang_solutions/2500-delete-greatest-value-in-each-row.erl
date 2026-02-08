-module(delete_greatest_value_in_each_row).
-export([delete_greatest_value/1]).

delete_greatest_value(Rows) ->
    lists:foldl(fun(Row, Acc) ->
        SortedRow = lists:sort(Row),
        [lists:last(SortedRow) | Acc]
    end, [], Rows).

delete_greatest_value([]) ->
    []; 
delete_greatest_value([[] | _]) ->
    [];
delete_greatest_value([Row | Rest]) ->
    SortedRow = lists:sort(Row),
    [lists:last(SortedRow) | delete_greatest_value(Rest)].