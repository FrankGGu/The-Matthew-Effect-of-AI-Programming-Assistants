-module(hitting_mole).
-export([hitBricks/1]).

hitBricks(Bricks) ->
    [H | T] = Bricks,
    Rows = length(Bricks),
    Cols = length(H),
    M = Rows,
    N = Cols,
    Grid = lists:map(fun(Row) -> list_to_tuple(Row) end, Bricks),
    Hit = lists:seq(0, M*N - 1),
    hitBricks(Grid, M, N, Hit).

hitBricks(_, _, _, []) ->
    [];
hitBricks(Grid, M, N, [I | T]) ->
    {R, C} = index_to_rc(I, M, N),
    case grid_get(Grid, R, C) of
        1 ->
            NewGrid = grid_set(Grid, R, C, 0),
            {NewGrid, Count} = dfs(NewGrid, M, N, R, C),
            [Count | hitBricks(NewGrid, M, N, T)];
        _ ->
            [0 | hitBricks(Grid, M, N, T)]
    end.

index_to_rc(I, M, N) ->
    R = I div N,
    C = I rem N,
    {R, C}.

grid_get(Grid, R, C) ->
    element(C + 1, element(R + 1, Grid)).

grid_set(Grid, R, C, Val) ->
    Row = element(R + 1, Grid),
    NewRow = setelement(C + 1, Row, Val),
    setelement(R + 1, Grid, NewRow).

dfs(Grid, M, N, R, C) ->
    dfs(Grid, M, N, R, C, 0, sets:new()).

dfs(_, _, _, _, _, Count, _) when R < 0 orelse R >= M orelse C < 0 orelse C >= N ->
    {Grid, Count};
dfs(Grid, M, N, R, C, Count, Visited) ->
    case sets:is_element({R, C}, Visited) of
        true ->
            {Grid, Count};
        false ->
            Visited2 = sets:add_element({R, C}, Visited),
            case grid_get(Grid, R, C) of
                1 ->
                    Count2 = Count + 1,
                    {Grid2, Count3} = dfs(Grid, M, N, R+1, C, Count2, Visited2),
                    {Grid3, Count4} = dfs(Grid2, M, N, R-1, C, Count3, Visited2),
                    {Grid4, Count5} = dfs(Grid3, M, N, R, C+1, Count4, Visited2),
                    {Grid5, Count6} = dfs(Grid4, M, N, R, C-1, Count5, Visited2),
                    {Grid5, Count6};
                _ ->
                    {Grid, Count}
            end
    end.