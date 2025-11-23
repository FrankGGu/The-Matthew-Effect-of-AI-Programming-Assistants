-module(solution).
-export([cells_in_range/1]).

cells_in_range(Range) ->
    [Start, End] = string:split(Range, ":"),
    StartCol = start_col(Start),
    StartRow = start_row(Start),
    EndCol = end_col(End),
    EndRow = end_row(End),
    generate_cells(StartCol, StartRow, EndCol, EndRow).

start_col(Str) ->
    lists:takewhile(fun(C) -> C >= $A andalso C =< $Z end, Str).

start_row(Str) ->
    list_to_integer(lists:dropwhile(fun(C) -> C >= $A andalso C =< $Z end, Str)).

end_col(Str) ->
    lists:takewhile(fun(C) -> C >= $A andalso C =< $Z end, Str).

end_row(Str) ->
    list_to_integer(lists:dropwhile(fun(C) -> C >= $A andalso C =< $Z end, Str)).

generate_cells(StartCol, StartRow, EndCol, EndRow) ->
    generate_cols(StartCol, EndCol, StartRow, EndRow, []).

generate_cols(Col, Col, Row, EndRow, Acc) ->
    generate_rows(Col, Row, EndRow, Acc);
generate_cols(StartCol, EndCol, Row, EndRow, Acc) ->
    NextCol = next_col(StartCol),
    generate_cols(NextCol, EndCol, Row, EndRow, Acc ++ generate_rows(StartCol, Row, EndRow, [])).

generate_rows(_, Row, Row, Acc) ->
    Acc ++ [row_col(Row, Row)];
generate_rows(Col, StartRow, EndRow, Acc) ->
    NextRow = StartRow + 1,
    generate_rows(Col, NextRow, EndRow, Acc ++ [row_col(StartRow, Col)]).

row_col(Row, Col) ->
    Col ++ integer_to_list(Row).

next_col("Z") ->
    "AA";
next_col(Col) ->
    case lists:last(Col) of
        $Z ->
            lists:sublist(Col, length(Col) - 1) ++ "AA";
        _ ->
            lists:sublist(Col, length(Col) - 1) ++ [lists:last(Col) + 1]
    end.