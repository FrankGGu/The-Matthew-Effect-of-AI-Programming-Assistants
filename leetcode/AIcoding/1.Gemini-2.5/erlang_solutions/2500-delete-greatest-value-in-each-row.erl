-module(solution).
-export([delete_greatest_value/1]).

delete_greatest_value(Grid) ->
    SortedGrid = lists:map(fun(Row) -> lists:sort(Row) end, Grid),
    delete_greatest_value_loop(SortedGrid, 0).

delete_greatest_value_loop(Rows, CurrentSum) ->
    case lists:all(fun(Row) -> Row == [] end, Rows) of
        true ->
            CurrentSum;
        false ->
            LastElements = [lists:last(Row) || Row <- Rows],
            MaxOfLast = lists:max(LastElements),
            NewRows = lists:map(fun(Row) -> lists:droplast(Row) end, Rows),
            delete_greatest_value_loop(NewRows, CurrentSum + MaxOfLast)
    end.