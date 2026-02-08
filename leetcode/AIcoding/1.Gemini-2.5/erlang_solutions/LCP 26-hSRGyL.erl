-module(solution).
-export([shortest_path/1]).

shortest_path(Grid) ->
    Rows = length(Grid),
    Cols = case Grid of
               [] -> 0;
               [H|_] -> length(H)
           end,

    if
        Rows =:= 0 orelse Cols =:= 0 -> -1;
        get_grid_val(Grid, 0, 0, Rows, Cols) =:= 1 -> -1;
        get_grid_val(Grid, Rows - 1, Cols - 1, Rows, Cols) =:= 1 -> -1;
        Rows =:= 1 andalso Cols =:= 1 -> 1;
        true ->
            bfs(Grid, Rows, Cols, {0, 0}, {Rows - 1, Cols - 1})
    end.

bfs(Grid, Rows, Cols, Start, Target) ->
    Q = queue:new(),
    Q1 = queue:in({Start, 1}, Q),

    Visited = sets:new(),
    Visited1 = sets:add(Start, Visited),

    bfs_loop(Q1, Visited1, Grid, Rows, Cols, Target).

bfs_loop(Q, Visited, Grid, Rows, Cols, Target) ->
    case queue:out(Q) of
        {{value, {{R, C}, Dist}}, RestQ} ->
            if
                {R, C} =:= Target -> Dist;
                true ->
                    Neighbors = get_neighbors(R, C, Rows, Cols, Grid),
                    {NewQ, NewVisited} = lists:foldl(
                        fun(Neighbor, {AccQ, AccVisited}) ->
                            case sets:is_element(Neighbor, AccVisited) of
                                true -> {AccQ, AccVisited};
                                false ->
                                    {queue:in({Neighbor, Dist + 1}, AccQ), sets:add(Neighbor, AccVisited)}
                            end
                        end,
                        {RestQ, Visited},
                        Neighbors
                    ),
                    bfs_loop(NewQ, NewVisited, Grid, Rows, Cols, Target)
            end;
        {empty, _} ->
            -1
    end.

get_neighbors(R, C, Rows, Cols, Grid) ->
    Dirs = [{0, 1}, {0, -1}, {1, 0}, {-1, 0}, {1, 1}, {1, -1}, {-1, 1}, {-1, -1}],

    lists:filtermap(
        fun({DR, DC}) ->
            NR = R + DR,
            NC = C + DC,
            if
                NR >= 0 andalso NR < Rows andalso NC >= 0 andalso NC < Cols andalso
                get_grid_val(Grid, NR, NC, Rows, Cols) =:= 0 ->
                    {true, {NR, NC}};
                true ->
                    false
            end
        end,
        Dirs
    ).

get_grid_val(Grid, R, C, Rows, Cols) ->
    if
        R >= 0 andalso R < Rows andalso C >= 0 andalso C < Cols ->
            lists:nth(C + 1, lists:nth(R + 1, Grid));
        true ->
            1
    end.