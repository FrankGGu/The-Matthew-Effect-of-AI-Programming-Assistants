-module(painted_row_or_column).
-export([first_complete_row_or_column/1]).

first_complete_row_or_column(Operations) ->
    Rows = 5,
    Cols = 5,
    RowCount = lists:seq(0, Rows - 1),
    ColCount = lists:seq(0, Cols - 1),
    {RowCount, ColCount, Operations, 0}.

first_complete_row_or_column(_, _, [], _) ->
    -1;
first_complete_row_or_column(RowCount, ColCount, [Pos | Rest], Step) ->
    Row = Pos div 5,
    Col = Pos rem 5,
    NewRowCount = lists:map(fun(R) -> if R == Row -> R + 1; true -> R end end, RowCount),
    NewColCount = lists:map(fun(C) -> if C == Col -> C + 1; true -> C end end, ColCount),
    case lists:member(5, NewRowCount) of
        true -> Step + 1;
        false ->
            case lists:member(5, NewColCount) of
                true -> Step + 1;
                false -> first_complete_row_or_column(NewRowCount, NewColCount, Rest, Step + 1)
            end
    end.