-module(solution).
-export([maxAreaOfIsland/1]).

maxAreaOfIsland(Grid) ->
    Rows = length(Grid),
    Cols = case Grid of
               [] -> 0;
               [H|_] -> length(H)
           end,

    maxAreaOfIsland_loop(Grid, Rows, Cols, 0, 0, 0, gb_sets:new()).

maxAreaOfIsland_loop(_Grid, Rows, _Cols, Rows, _C, MaxArea, _Visited) ->
    MaxArea;
maxAreaOfIsland_loop(Grid, Rows, Cols, R, Cols, CurrentMaxArea, Visited) ->
    maxAreaOfIsland_loop(Grid, Rows, Cols, R + 1, 0, CurrentMaxArea, Visited);
maxAreaOfIsland_loop(Grid, Rows, Cols, R, C, CurrentMaxArea, Visited) ->
    CellVal = get_cell(Grid, R, C),

    case {CellVal, gb_sets:is_member({R, C}, Visited)} of
        {1, false} ->
            {IslandArea, NewVisited} = dfs(Grid, R, C, Rows, Cols, Visited),
            NewMaxArea = max(CurrentMaxArea, IslandArea),
            maxAreaOfIsland_loop(Grid, Rows, Cols, R, C + 1, NewMaxArea, NewVisited);
        _ ->
            maxAreaOfIsland_loop(Grid, Rows, Cols, R, C + 1, CurrentMaxArea, Visited)
    end.

dfs(Grid, R, C, Rows, Cols, Visited) ->
    if
        R < 0 orelse R >= Rows orelse C < 0 orelse C >= Cols ->
            {0, Visited};
        gb_sets:is_member({R, C}, Visited) ->
            {0, Visited};
        get_cell(Grid, R, C) == 0 ->
            {0, Visited}
    else
        NewVisited = gb_sets:add({R, C}, Visited),
        Area = 1,

        Neighbors = [{R-1, C}, {R+1, C}, {R, C-1}, {R, C+1}],

        lists:foldl(fun({NR, NC}, {AccArea, AccVisited}) ->
                        {NbrArea, UpdatedVisited} = dfs(Grid, NR, NC, Rows, Cols, AccVisited),
                        {AccArea + NbrArea, UpdatedVisited}
                    end, {Area, NewVisited}, Neighbors)
    end.

get_cell(Grid, R, C) ->
    lists:nth(C + 1, lists:nth(R + 1, Grid)).