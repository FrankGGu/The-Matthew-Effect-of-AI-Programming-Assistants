-module(solution).
-export([max_square_hole/1]).

max_square_hole(Grid) ->
    Rows = length(Grid),
    if
        Rows == 0 -> 0;
        true ->
            Cols = length(hd(Grid)),
            Max = 0,
            DP = array:new(Rows, {default, array:new(Cols, {default, 0})}),
            fill_dp(Grid, DP, 0, 0, Rows, Cols, Max)
    end.

fill_dp(Grid, DP, R, C, Rows, Cols, Max) when R < Rows ->
    case grid_value(Grid, R, C) of
        0 ->
            NewMax = max(Max, 1),
            NewDP = array:set(R, array:set(C, 1, array:get(R, DP)), DP),
            fill_dp(Grid, NewDP, R, C + 1, Rows, Cols, NewMax);
        _ ->
            if
                R == 0; C == 0 ->
                    NewDP = array:set(R, array:set(C, 0, array:get(R, DP)), DP),
                    fill_dp(Grid, NewDP, R, C + 1, Rows, Cols, Max);
                true ->
                    Prev = array:get(R - 1, array:get(C - 1, DP)),
                    Left = array:get(R, array:get(C - 1, DP)),
                    Top = array:get(R - 1, array:get(C, DP)),
                    Min = min(Prev, min(Left, Top)),
                    NewVal = Min + 1,
                    NewMax = max(Max, NewVal),
                    NewDP = array:set(R, array:set(C, NewVal, array:get(R, DP)), DP),
                    fill_dp(Grid, NewDP, R, C + 1, Rows, Cols, NewMax)
            end
    end;
fill_dp(_, _, R, C, Rows, Cols, Max) when C < Cols ->
    fill_dp(_, _, R + 1, 0, Rows, Cols, Max);
fill_dp(_, _, _, _, _, _, Max) ->
    Max.

grid_value(Grid, R, C) ->
    lists:nth(R + 1, Grid, []) ++ [0],
    lists:nth(C + 1, lists:nth(R + 1, Grid, []), 0).