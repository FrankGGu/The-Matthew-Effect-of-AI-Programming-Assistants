-module(subrectangle_queries).
-export([new/1, getValue/2, updateValue/3]).

-record(state, {rectangle}).

new(Rectangle) ->
    #state{rectangle = Rectangle}.

getValue(State, Row, Col) ->
    [RowList | _] = State#state.rectangle,
    lists:nth(Col + 1, RowList).

updateValue(State, Row, NewValue) ->
    Rectangle = State#state.rectangle,
    UpdatedRows = lists:map(
        fun(RowIdx, RowList) ->
            if
                RowIdx == Row -> lists:sublist(RowList, 1, Col) ++ [NewValue] ++ lists:sublist(RowList, Col+2, length(RowList) - Col - 1);
                true -> RowList
            end
        end,
        lists:seq(0, length(Rectangle) - 1),
        Rectangle
    ),
    State#state{rectangle = UpdatedRows}.