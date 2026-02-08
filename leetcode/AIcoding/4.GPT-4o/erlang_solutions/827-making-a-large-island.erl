-module(solution).
-export([largest_island/1]).

largest_island(Grid) ->
    case largest_island_helper(Grid, 0, 0, 0, dict:new()) of
        {MaxArea, _} -> MaxArea
    end.

largest_island_helper([], _, MaxArea, _, Visited) -> {MaxArea, Visited};
largest_island_helper([Row | Rest], R, MaxArea, Visited) ->
    largest_island_helper_row(Row, R, 0, 0, MaxArea, Visited, Rest).

largest_island_helper_row([], _, _, _, MaxArea, Visited, Rest) ->
    largest_island_helper(Rest, R + 1, MaxArea, Visited);
largest_island_helper_row([0 | RowTail], R, C, CurArea, MaxArea, Visited, Rest) ->
    largest_island_helper_row(RowTail, R, C + 1, CurArea, MaxArea, Visited, Rest);
largest_island_helper_row([1 | RowTail], R, C, CurArea, MaxArea, Visited, Rest) ->
    case dict:find({R, C}, Visited) of
        ok -> largest_island_helper_row(RowTail, R, C + 1, CurArea, MaxArea, Visited, Rest);
        error ->
            NewArea = dfs(Grid, R, C, Visited),
            largest_island_helper_row(RowTail, R, C + 1, CurArea + NewArea, max(MaxArea, CurArea + NewArea), dict:store({R, C}, NewArea, Visited), Rest)
    end.

dfs(Grid, R, C, Visited) ->
    if
        R < 0 orelse C < 0 orelse R >= length(Grid) orelse C >= length(hd(Grid)) orelse dict:find({R, C}, Visited) =:= ok orelse lists:nth(R + 1, Grid) =:= [] orelse lists:nth(C + 1, lists:nth(R + 1, Grid)) =:= 0 ->
            0;
        true ->
            Visited1 = dict:store({R, C}, true, Visited),
            1 + dfs(Grid, R + 1, C, Visited1) +
            dfs(Grid, R - 1, C, Visited1) +
            dfs(Grid, R, C + 1, Visited1) +
            dfs(Grid, R, C - 1, Visited1)
    end.