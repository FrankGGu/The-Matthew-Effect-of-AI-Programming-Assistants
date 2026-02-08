-module(bricks_falling_when_hit).
-export([bricks_fall/2]).

bricks_fall(Hit, Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    {GridCopy, HitSet} = prepare_grid(Hit, Grid, Rows, Cols),
    {_, Result} = process_hits(HitSet, GridCopy, Rows, Cols),
    Result.

prepare_grid([], Grid, _, _) ->
    {Grid, sets:new()};
prepare_grid([H | T], Grid, Rows, Cols) ->
    [R, C] = H,
    case R >= 0 andalso R < Rows andalso C >= 0 andalso C < Cols of
        true ->
            NewGrid = update_grid(Grid, R, C, 0),
            {NewGrid, sets:add_element({R, C}, prepare_grid(T, Grid, Rows, Cols))};
        false ->
            prepare_grid(T, Grid, Rows, Cols)
    end.

update_grid(Grid, R, C, Val) ->
    lists:sublist(Grid, R) ++ [lists:sublist(lists:nth(R + 1, Grid), C) ++ [Val] ++ lists:sublist(lists:nth(R + 1, Grid), C + 1, length(lists:nth(R + 1, Grid)) - C)] ++ lists:sublist(Grid, R + 1, length(Grid) - R - 1).

process_hits(_, Grid, _, _) when Grid == [] -> {0, []};
process_hits(HitSet, Grid, Rows, Cols) ->
    {Connected, _} = dfs(Grid, Rows, Cols),
    process_hits(HitSet, Grid, Connected, Rows, Cols).

process_hits(HitSet, Grid, Connected, Rows, Cols) ->
    process_hits(HitSet, Grid, Connected, Rows, Cols, []).

process_hits([], _, _, _, _, Acc) ->
    lists:reverse(Acc);
process_hits([{R, C} | T], Grid, Connected, Rows, Cols, Acc) ->
    case lists:keymember({R, C}, 1, Connected) of
        true ->
            NewGrid = update_grid(Grid, R, C, 1),
            {NewConnected, _} = dfs(NewGrid, Rows, Cols),
            Count = length(Connected) - length(NewConnected),
            process_hits(T, NewGrid, NewConnected, Rows, Cols, [Count | Acc]);
        false ->
            process_hits(T, Grid, Connected, Rows, Cols, [0 | Acc])
    end.

dfs(Grid, Rows, Cols) ->
    Visited = sets:new(),
    Connected = [],
    dfs_helper(Grid, 0, 0, Rows, Cols, Visited, Connected).

dfs_helper(_, R, C, Rows, Cols, Visited, Connected) when R >= Rows ->
    {Connected, Visited};
dfs_helper(_, R, C, Rows, Cols, Visited, Connected) when C >= Cols ->
    dfs_helper(Grid, R + 1, 0, Rows, Cols, Visited, Connected);
dfs_helper(Grid, R, C, Rows, Cols, Visited, Connected) ->
    case lists:nth(R + 1, Grid) -- [C + 1] of
        1 ->
            case sets:is_element({R, C}, Visited) of
                false ->
                    NewVisited = sets:add_element({R, C}, Visited),
                    {NewConnected, NewVisited} = dfs_helper(Grid, R, C + 1, Rows, Cols, NewVisited, Connected),
                    {NewConnected2, NewVisited2} = dfs_helper(Grid, R + 1, C, Rows, Cols, NewVisited, NewConnected),
                    {NewConnected3, NewVisited3} = dfs_helper(Grid, R, C - 1, Rows, Cols, NewVisited2, NewConnected2),
                    {NewConnected4, NewVisited4} = dfs_helper(Grid, R - 1, C, Rows, Cols, NewVisited3, NewConnected3),
                    {NewConnected4, NewVisited4};
                true ->
                    dfs_helper(Grid, R, C + 1, Rows, Cols, Visited, Connected)
            end;
        _ ->
            dfs_helper(Grid, R, C + 1, Rows, Cols, Visited, Connected)
    end.