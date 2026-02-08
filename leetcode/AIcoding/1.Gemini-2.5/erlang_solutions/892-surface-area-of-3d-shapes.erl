-module(solution).
-export([surfaceArea/1]).

surfaceArea(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    calculate_area(Grid, Rows, Cols, 0, 0, 0).

calculate_area(Grid, Rows, Cols, I, J, CurrentArea) when I < Rows ->
    Row = lists:nth(I + 1, Grid),
    H = lists:nth(J + 1, Row),

    AreaWithCurrent = if H > 0 -> CurrentArea + 2 + (4 * H);
                         true -> CurrentArea
                      end,

    AreaAfterNorth = if I > 0 andalso H > 0 ->
                            PrevRow = lists:nth(I, Grid),
                            NH = lists:nth(J + 1, PrevRow),
                            AreaWithCurrent - (min(H, NH) * 2);
                        true -> AreaWithCurrent
                     end,

    AreaAfterWest = if J > 0 andalso H > 0 ->
                           WH = lists:nth(J, Row),
                           AreaAfterNorth - (min(H, WH) * 2);
                       true -> AreaAfterNorth
                    end,

    NextJ = J + 1,
    if NextJ < Cols ->
        calculate_area(Grid, Rows, Cols, I, NextJ, AreaAfterWest);
    true -> % Move to next row
        calculate_area(Grid, Rows, Cols, I + 1, 0, AreaAfterWest)
    end;
calculate_area(_Grid, _Rows, _Cols, _I, _J, FinalArea) ->
    FinalArea.