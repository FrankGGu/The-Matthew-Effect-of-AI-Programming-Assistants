-module(shift_2d_grid).
-export([shift_grid/2]).

shift_grid(Grid, K) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    Total = Rows * Cols,
    KMod = K rem Total,

    fun shift(Row, Col) ->
        NewIndex = (Row * Cols + Col + KMod) rem Total,
        NewRow = NewIndex div Cols,
        NewCol = NewIndex rem Cols,
        {NewRow, NewCol}
    end,

    NewGrid = lists:seq(0, Rows - 1)
              |> lists:map(fun(Row) ->
                                  lists:seq(0, Cols - 1)
                                  |> lists:map(fun(Col) ->
                                                      {NewRow, NewCol} = shift(Row, Col),
                                                      lists:nth(NewCol+1, lists:nth(NewRow+1, Grid))
                                                  end)
                              end),
    NewGrid.