-module(max_fish).
-export([find_max_fish/1]).

find_max_fish(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    MaxFish = 0,
    find_max_fish(Grid, 0, 0, Rows, Cols, MaxFish).

find_max_fish(_, R, C, Rows, Cols, MaxFish) when R >= Rows ->
    MaxFish;
find_max_fish(Grid, R, C, Rows, Cols, MaxFish) when C >= Cols ->
    find_max_fish(Grid, R + 1, 0, Rows, Cols, MaxFish);
find_max_fish(Grid, R, C, Rows, Cols, MaxFish) ->
    case lists:nth(R + 1, Grid) of
        Row ->
            Fish = lists:nth(C + 1, Row),
            if
                Fish > 0 ->
                    Visited = [],
                    {Total, _} = dfs(Grid, R, C, Rows, Cols, Visited, Fish),
                    find_max_fish(Grid, R, C + 1, Rows, Cols, max(MaxFish, Total));
                true ->
                    find_max_fish(Grid, R, C + 1, Rows, Cols, MaxFish)
            end
    end.

dfs(_, R, C, Rows, Cols, Visited, Fish) when R < 0 orelse R >= Rows orelse C < 0 orelse C >= Cols ->
    {0, Visited};
dfs(Grid, R, C, Rows, Cols, Visited, Fish) ->
    Current = lists:nth(R + 1, Grid),
    CurrentFish = lists:nth(C + 1, Current),
    if
        CurrentFish == 0 -> {0, Visited};
        lists:member({R, C}, Visited) -> {0, Visited};
        true ->
            NewVisited = [{R, C} | Visited],
            {Up, UpVisited} = dfs(Grid, R - 1, C, Rows, Cols, NewVisited, Fish),
            {Down, DownVisited} = dfs(Grid, R + 1, C, Rows, Cols, UpVisited, Fish),
            {Left, LeftVisited} = dfs(Grid, R, C - 1, Rows, Cols, DownVisited, Fish),
            {Right, RightVisited} = dfs(Grid, R, C + 1, Rows, Cols, LeftVisited, Fish),
            Total = CurrentFish + Up + Down + Left + Right,
            {Total, RightVisited}
    end.