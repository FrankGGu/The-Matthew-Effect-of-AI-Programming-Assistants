-module(subrectangle_queries).
-export([init/1, updateSubrectangle/4, getValue/3]).

-record(subrectangle_queries, {rectangle}).

init(Rectangle) ->
    #subrectangle_queries{rectangle = Rectangle}.

updateSubrectangle(#subrectangle_queries{rectangle = Rect}, Row1, Col1, Row2, Col2, NewValue) ->
    UpdatedRect = lists:map(fun(RowIdx) ->
        lists:map(fun(ColIdx) ->
            case (RowIdx >= Row1 andalso RowIdx =< Row2 andalso ColIdx >= Col1 andalso ColIdx =< Col2) of
                true -> NewValue;
                false -> lists:nth(ColIdx + 1, lists:nth(RowIdx + 1, Rect))
            end
        end, lists:seq(0, length(lists:nth(1, Rect)) - 1))
    end, lists:seq(0, length(Rect) - 1)),
    #subrectangle_queries{rectangle = UpdatedRect}.

getValue(#subrectangle_queries{rectangle = Rect}, Row, Col) ->
    lists:nth(Col + 1, lists:nth(Row + 1, Rect)).