-module(delete_greatest_value).
-export([delete_greatest_value/1]).

delete_greatest_value(Grid) ->
    delete_greatest_value_helper(Grid, 0).

delete_greatest_value_helper([], Sum) ->
    Sum;
delete_greatest_value_helper(Grid, Sum) ->
    Maxes = [lists:max(Row) || Row <- Grid],
    Max_Val = lists:max(Maxes),
    New_Grid = [remove_max(Row) || Row <- Grid],
    delete_greatest_value_helper(New_Grid, Sum + Max_Val).

remove_max(Row) ->
    Max_Val = lists:max(Row),
    remove_max_helper(Row, Max_Val, []).

remove_max_helper([], _, Acc) ->
    lists:reverse(Acc);
remove_max_helper([H|T], Max_Val, Acc) ->
    if
        H == Max_Val ->
            lists:reverse(Acc) ++ T;
        true ->
            remove_max_helper(T, Max_Val, [H|Acc])
    end.