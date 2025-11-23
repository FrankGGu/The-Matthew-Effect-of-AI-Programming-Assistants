-module(solution).
-export([getMaximumGold/1]).

getMaximumGold(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    MaxGold = 0,
    lists:foldl(fun(R, CurrentMax) ->
        lists:foldl(fun(C, InnerMax) ->
            Gold = get_gold_at(Grid, R, C),
            if Gold > 0 ->
                PathGold = dfs(Grid, R, C, sets:new(), Rows, Cols),
                max(PathGold, InnerMax)
            else
                InnerMax
            end
        end, CurrentMax, lists:seq(0, Cols - 1))
    end, MaxGold, lists:seq(0, Rows - 1)).

dfs(Grid, R, C, Visited, Rows, Cols) ->
    if R < 0 or R >= Rows or C < 0 or C >= Cols ->
        0;
    true ->
        Gold = get_gold_at(Grid, R, C),
        if Gold == 0 or sets:is_element({R, C}, Visited) ->
            0;
        true ->
            NewVisited = sets:add_element({R, C}, Visited),

            NeighborsGold = [
                dfs(Grid, R + 1, C, NewVisited, Rows, Cols),
                dfs(Grid, R - 1, C, NewVisited, Rows, Cols),
                dfs(Grid, R, C + 1, NewVisited, Rows, Cols),
                dfs(Grid, R, C - 1, NewVisited, Rows, Cols)
            ],

            MaxNeighborPathGold = lists:max(NeighborsGold),

            Gold + MaxNeighborPathGold
        end
    end.

get_gold_at(Grid, R, C) ->
    lists:nth(C + 1, lists:nth(R + 1, Grid)).