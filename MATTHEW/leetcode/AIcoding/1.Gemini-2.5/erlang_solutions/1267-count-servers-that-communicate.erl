-module(solution).
-export([countServers/1]).

countServers(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),

    RowSumsList = lists:map(fun(Row) -> lists:sum(Row) end, Grid),
    RowSumsTuple = list_to_tuple(RowSumsList),

    InitialColSums = lists:duplicate(Cols, 0),
    ColSumsList = lists:foldl(
        fun(Row, AccColSums) ->
            lists:zipwith(fun(Cell, ColSum) -> Cell + ColSum end, Row, AccColSums)
        end,
        InitialColSums,
        Grid
    ),
    ColSumsTuple = list_to_tuple(ColSumsList),

    count_communicating_final(Grid, RowSumsTuple, ColSumsTuple, 0, Cols, 0).

count_communicating_final([CurrentRow | RestRows], RowSumsTuple, ColSumsTuple, RowIndex, Cols, Acc) ->
    RowResult = process_row(CurrentRow, RowIndex, ColSumsTuple, RowSumsTuple, 0, Cols, 0),
    count_communicating_final(RestRows, RowSumsTuple, ColSumsTuple, RowIndex + 1, Cols, Acc + RowResult);
count_communicating_final([], _RowSumsTuple, _ColSumsTuple, _RowIndex, _Cols, Acc) ->
    Acc.

process_row([Cell | RestCells], RowIndex, ColSumsTuple, RowSumsTuple, ColIndex, Cols, Acc) ->
    NewAcc =
        case Cell of
            1 ->
                RowSum = element(RowIndex + 1, RowSumsTuple),
                ColSum = element(ColIndex + 1, ColSumsTuple),
                if
                    RowSum > 1; ColSum > 1 -> Acc + 1;
                    true -> Acc
                end;
            _ -> Acc
        end,
    process_row(RestCells, RowIndex, ColSumsTuple, RowSumsTuple, ColIndex + 1, Cols, NewAcc);
process_row([], _RowIndex, _ColSumsTuple, _RowSumsTuple, _ColIndex, _Cols, Acc) ->
    Acc.