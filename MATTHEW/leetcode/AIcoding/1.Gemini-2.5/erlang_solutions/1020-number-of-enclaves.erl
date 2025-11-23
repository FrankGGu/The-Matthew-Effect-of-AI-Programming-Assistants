-module(solution).
-export([numEnclaves/1]).

numEnclaves(Grid) ->
    MaxRows = length(Grid),
    MaxCols = length(hd(Grid)),

    Visited = sets:new(),

    BoundaryVisited = dfs_boundary(Grid, Visited, MaxRows, MaxCols),

    EnclaveCount = count_enclaves(Grid, 0, MaxRows - 1, 0, MaxCols - 1, BoundaryVisited, 0, MaxRows, MaxCols),

    EnclaveCount.

dfs_boundary(Grid, Visited, MaxRows, MaxCols) ->
    % Process top and bottom rows
    Visited1 = lists:foldl(
        fun(Col, AccVisited) ->
            TopRowVal = lists:nth(Col + 1, lists:nth(1, Grid)),
            BottomRowVal = lists:nth(Col + 1, lists:nth(MaxRows, Grid)),
            AccVisited1 = if TopRowVal == 1 -> dfs(Grid, 0, Col, AccVisited, MaxRows, MaxCols); true -> AccVisited end,
            if BottomRowVal == 1 -> dfs(Grid, MaxRows - 1, Col, AccVisited1, MaxRows, MaxCols); true -> AccVisited1 end
        end,
        Visited,
        lists:seq(0, MaxCols - 1)
    ),
    % Process left and right columns (excluding corners already handled by top/bottom rows)
    Visited2 = lists:foldl(
        fun(Row, AccVisited) ->
            LeftColVal = lists:nth(1, lists:nth(Row + 1, Grid)),
            RightColVal = lists:nth(MaxCols, lists:nth(Row + 1, Grid)),
            AccVisited1 = if LeftColVal == 1 -> dfs(Grid, Row, 0, AccVisited, MaxRows, MaxCols); true -> AccVisited end,
            if RightColVal == 1 -> dfs(Grid, Row, MaxCols - 1, AccVisited1, MaxRows, MaxCols); true -> AccVisited1 end
        end,
        Visited1,
        lists:seq(1, MaxRows - 2)
    ),
    Visited2.

dfs(Grid, R, C, Visited, MaxRows, MaxCols) ->
    if
        R < 0; R >= MaxRows; C < 0; C >= MaxCols -> Visited;
        true ->
            if sets:is_element({R, C}, Visited) -> Visited;
            true ->
                CellValue = lists:nth(C + 1, lists:nth(R + 1, Grid)),
                if
                    CellValue == 0 -> Visited;
                    true ->
                        NewVisited = sets:add_element({R, C}, Visited),
                        NewVisited1 = dfs(Grid, R + 1, C, NewVisited, MaxRows, MaxCols),
                        NewVisited2 = dfs(Grid, R - 1, C, NewVisited1, MaxRows, MaxCols),
                        NewVisited3 = dfs(Grid, R, C + 1, NewVisited2, MaxRows, MaxCols),
                        dfs(Grid, R, C - 1, NewVisited3, MaxRows, MaxCols)
                end
            end
    end.

count_enclaves(Grid, R, MaxR, C, MaxC, BoundaryVisited, Count, MaxRows, MaxCols) ->
    if
        R > MaxR -> Count;
        true ->
            CurrentRow = lists:nth(R + 1, Grid),
            RowEnclaveCount = lists:foldl(
                fun(Col, AccCount) ->
                    CellValue = lists:nth(Col + 1, CurrentRow),
                    if
                        CellValue == 1 andalso not sets:is_element({R, Col}, BoundaryVisited) -> AccCount + 1;
                        true -> AccCount
                    end
                end,
                0,
                lists:seq(0, MaxC)
            ),
            count_enclaves(Grid, R + 1, MaxR, C, MaxC, BoundaryVisited, Count + RowEnclaveCount, MaxRows, MaxCols)
    end.