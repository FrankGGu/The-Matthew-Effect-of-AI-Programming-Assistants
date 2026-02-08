-module(solution).
-export([odd_cells/3]).

odd_cells(RowCount, ColCount, indices) ->
    Matrix = lists:duplicate(RowCount, lists:duplicate(ColCount, 0)),
    UpdatedMatrix = lists:foldl(fun({r, c}, Acc) ->
        lists:map(fun(Row, RIndex) ->
            lists:map(fun(Value, CIndex) ->
                case {RIndex, CIndex} of
                    {r, _} when RIndex =< RowCount -> Value + 1;
                    {_, c} when CIndex =< ColCount -> Value + 1;
                    _ -> Value
                end
            end, Row)
        end, Acc, indices),
    lists:sum(lists:map(fun(Row) -> length(list_filter(fun(X) -> X rem 2 =:= 1 end, Row)) end, UpdatedMatrix)).

list_filter(Pred, List) ->
    lists:filter(Pred, List).