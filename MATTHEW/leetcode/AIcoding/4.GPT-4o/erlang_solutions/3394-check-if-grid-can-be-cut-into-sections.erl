-module(solution).
-export([check_grid/1]).

check_grid(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    check_sections(Grid, Rows, Cols).

check_sections(Grid, Rows, Cols) ->
    case check_rows(Grid, Rows, Cols, 0, []) of
        false -> false;
        _ -> check_cols(Grid, Rows, Cols, 0, [])
    end.

check_rows([], _, _, _, Acc) -> Acc;
check_rows([Row | Rest], Rows, Cols, Index, Acc) ->
    case check_row(Row, Cols) of
        true ->
            check_rows(Rest, Rows, Cols, Index + 1, [Row | Acc]);
        false -> false
    end.

check_row(Row, Cols) ->
    RowLength = length(Row),
    RowLength =:= Cols.

check_cols(Grid, Rows, Cols, Index, Acc) ->
    case Index < Cols of
        false -> true;
        true ->
            Column = get_column(Grid, Index, Rows, []),
            case check_row(Column, Rows) of
                true -> check_cols(Grid, Rows, Cols, Index + 1, Acc);
                false -> false
            end
    end.

get_column([], _, _, Acc) -> lists:reverse(Acc);
get_column([Row | Rest], Index, Rows, Acc) ->
    NewAcc = [lists:nth(Index + 1, Row) | Acc],
    get_column(Rest, Index, Rows, NewAcc).

check_section(Section) ->
    lists:all(fun(X) -> X =:= hd(Section) end, Section).