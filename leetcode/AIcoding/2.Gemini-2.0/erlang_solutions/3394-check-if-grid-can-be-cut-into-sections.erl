-module(check_grid_sections).
-export([solve/1]).

solve(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    {TotalOnes, FirstRowOnes, FirstColOnes} = count_ones(Grid, Rows, Cols),

    case TotalOnes > 0 of
        true ->
            case FirstRowOnes > 0 andalso FirstColOnes > 0 of
                true ->
                    Subgrid = get_subgrid(Grid, Rows, Cols),
                    SubgridOnes = count_subgrid_ones(Subgrid),
                    SubgridOnes == TotalOnes - FirstRowOnes - FirstColOnes + (lists:nth(1, lists:nth(1, Grid)) =:= 1)
                false ->
                    true
            end;
        false ->
            true
    end.

count_ones(Grid, Rows, Cols) ->
    count_ones_helper(Grid, Rows, Cols, 0, 0, 0, 0).

count_ones_helper([], _, _, Total, _, _, _) ->
    {Total, 0, 0};
count_ones_helper([Row | Rest], Rows, Cols, Total, FirstRow, FirstCol, RowIndex) ->
    {RowTotal, NewFirstCol} = count_row_ones(Row, Cols, 0, 0, 0),
    NewTotal = Total + RowTotal,
    NewFirstRow = case RowIndex =:= 0 of
                      true -> RowTotal;
                      false -> FirstRow
                  end,
    {NewTotal, NewFirstRow, NewFirstCol} = case RowIndex =:= 0 of
                                              true -> {NewTotal, NewFirstRow, NewFirstCol};
                                              false -> {NewTotal, NewFirstRow, FirstCol}
                                          end,
    count_ones_helper(Rest, Rows, Cols, NewTotal, NewFirstRow, NewFirstCol, RowIndex + 1).

count_row_ones([], _, Total, FirstCol, ColIndex) ->
    {Total, FirstCol};
count_row_ones([Val | Rest], Cols, Total, FirstCol, ColIndex) ->
    NewTotal = Total + Val,
    NewFirstCol = case ColIndex =:= 0 of
                      true -> Val;
                      false -> FirstCol
                  end,
    count_row_ones(Rest, Cols, NewTotal, NewFirstCol, ColIndex + 1).

get_subgrid(Grid, Rows, Cols) ->
    [lists:sublist(Row, 2, Cols - 1) || Row <- lists:sublist(Grid, 2, Rows - 1)].

count_subgrid_ones(Subgrid) ->
    lists:sum([lists:sum(Row) || Row <- Subgrid]).