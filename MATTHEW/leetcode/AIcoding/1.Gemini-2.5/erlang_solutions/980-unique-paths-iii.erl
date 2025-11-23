-module(solution).
-export([unique_paths_iii/1]).

get_cell(Grid, R, C) ->
    lists:nth(C + 1, lists:nth(R + 1, Grid)).

unique_paths_iii(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),

    {StartR, StartC, EndR, EndC, WalkableCells} =
        find_grid_elements(Grid, Rows, Cols, 0, 0, 0, 0, 0, 0, 0),

    dfs(Grid, Rows, Cols, StartR, StartC, EndR, EndC, gb_sets:new(), 0, WalkableCells).

find_grid_elements(Grid, Rows, Cols, R, C, AccStartR, AccStartC, AccEndR, AccEndC, AccWalkableCells) ->
    case R of
        Rows ->
            {AccStartR, AccStartC, AccEndR, AccEndC, AccWalkableCells};
        _ ->
            case C of
                Cols ->
                    find_grid_elements(Grid, Rows, Cols, R + 1, 0, AccStartR, AccStartC, AccEndR, AccEndC, AccWalkableCells);
                _ ->
                    Val = get_cell(Grid, R, C),
                    NewAccStartR = case Val of 1 -> R; _ -> AccStartR end,
                    NewAccStartC = case Val of 1 -> C; _ -> AccStartC end,
                    NewAccEndR = case Val of 2 -> R; _ -> AccEndR end,
                    NewAccEndC = case Val of 2 -> C; _ -> AccEndC end,
                    NewAccWalkableCells = case Val of -1 -> AccWalkableCells; _ -> AccWalkableCells + 1 end,
                    find_grid_elements(Grid, Rows, Cols, R, C + 1, NewAccStartR, NewAccStartC, NewAccEndR, NewAccEndC, NewAccWalkableCells)
            end
    end.

dfs(Grid, Rows, Cols, R, C, EndR, EndC, VisitedSet, CurrentVisitedCount, TargetVisitedCount) ->
    if
        R < 0; R >= Rows; C < 0; C >= Cols ->
            0;
        true ->
            Val = get_cell(Grid, R, C),
            if
                Val == -1 ->
                    0;
                true ->
                    if
                        gb_sets:is_member({R, C}, VisitedSet) ->
                            0;
                        true ->
                            NewVisitedSet = gb_sets:add({R, C}, VisitedSet),
                            NewCurrentVisitedCount = CurrentVisitedCount + 1,

                            if
                                R == EndR andalso C == EndC ->
                                    if
                                        NewCurrentVisitedCount == TargetVisitedCount ->
                                            1;
                                        true ->
                                            0
                                    end;
                                true ->
                                    Sum1 = dfs(Grid, Rows, Cols, R + 1, C, EndR, EndC, NewVisitedSet, NewCurrentVisitedCount, TargetVisitedCount),
                                    Sum2 = dfs(Grid, Rows, Cols, R - 1, C, EndR, EndC, NewVisitedSet, NewCurrentVisitedCount, TargetVisitedCount),
                                    Sum3 = dfs(Grid, Rows, Cols, R, C + 1, EndR, EndC, NewVisitedSet, NewCurrentVisitedCount, TargetVisitedCount),
                                    Sum4 = dfs(Grid, Rows, Cols, R, C - 1, EndR, EndC, NewVisitedSet, NewCurrentVisitedCount, TargetVisitedCount),
                                    Sum1 + Sum2 + Sum3 + Sum4
                            end
                    end
            end
    end.