-module(subrectangle_queries).
-export([new/1, update_subrectangle/4, get_value/3]).

new(rectangle) ->
    {ok, rectangle}.

update_subrectangle(TopLeftRow, TopLeftCol, BottomRightRow, BottomRightCol, NewValue, {ok, Rectangle}) ->
    UpdatedRectangle = update_rectangle(TopLeftRow, TopLeftCol, BottomRightRow, BottomRightCol, NewValue, Rectangle),
    {ok, UpdatedRectangle}.

get_value(Row, Col, {ok, Rectangle}) ->
    lists:nth(Col + 1, lists:nth(Row + 1, Rectangle)).

update_rectangle(TopLeftRow, TopLeftCol, BottomRightRow, BottomRightCol, NewValue, Rectangle) ->
    lists:map(fun(RowIndex, Row) ->
                      case (RowIndex >= TopLeftRow) and (RowIndex =< BottomRightRow) of
                          true ->
                              lists:map(fun(ColIndex, Val) ->
                                                case (ColIndex >= TopLeftCol) and (ColIndex =< BottomRightCol) of
                                                    true -> NewValue;
                                                    false -> Val
                                                end
                                        end, lists:seq(0, length(Row) - 1), Row);
                          false -> Row
                      end
              end, lists:seq(0, length(Rectangle) - 1), Rectangle).