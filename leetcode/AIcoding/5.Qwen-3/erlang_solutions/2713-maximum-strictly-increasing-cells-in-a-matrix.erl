-module(maximum_strictly_increasing_cells_in_a_matrix).
-export([max_increasing_cells/1]).

max_increasing_cells(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    DP = array:new({size, Rows * Cols}, {default, 0}),
    Cells = lists:foldl(fun(RowIndex, Acc) ->
        lists:foldl(fun(ColIndex, Acc2) ->
            CellValue = lists:nth(ColIndex + 1, lists:nth(RowIndex + 1, Grid)),
            {R, C} = {RowIndex, ColIndex},
            MaxVal = get_max_from_neighbors(Grid, R, C, DP),
            NewVal = MaxVal + 1,
            array:set(R * Cols + C, NewVal, DP),
            [{R, C, CellValue} | Acc2]
        end, Acc, lists:seq(0, Cols - 1))
    end, [], lists:seq(0, Rows - 1)),

    lists:foldl(fun({_R, _C, Val}, Max) -> max(Val, Max) end, 0, Cells).

get_max_from_neighbors(Grid, R, C, DP) ->
    Max = 0,
    Neighbors = [
        {R - 1, C},
        {R + 1, C},
        {R, C - 1},
        {R, C + 1}
    ],
    lists:foldl(fun({NR, NC}, Acc) ->
        if
            NR >= 0, NR < length(Grid), NC >= 0, NC < length(hd(Grid)) ->
                NeighborVal = lists:nth(NC + 1, lists:nth(NR + 1, Grid)),
                CurrentVal = lists:nth(C + 1, lists:nth(R + 1, Grid)),
                if
                    NeighborVal < CurrentVal ->
                        Val = array:get(NR * length(hd(Grid)) + NC, DP),
                        max(Acc, Val);
                    true ->
                        Acc
                end;
            true ->
                Acc
        end
    end, Max, Neighbors).