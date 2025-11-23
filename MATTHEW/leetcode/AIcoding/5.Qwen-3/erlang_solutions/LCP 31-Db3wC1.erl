-module(maze).
-export([hasPath/3]).

hasPath(Start, Destination, Maze) ->
    Rows = length(Maze),
    Cols = length(hd(Maze)),
    Visited = array:new(Rows * Cols, {default, false}),
    dfs(Start, Destination, Maze, Visited, Rows, Cols).

dfs([X, Y], [Dx, Dy], Maze, Visited, Rows, Cols) ->
    case (X < 0) orelse (X >= Rows) orelse (Y < 0) orelse (Y >= Cols) of
        true -> false;
        _ ->
            Index = X * Cols + Y,
            case array:get(Index, Visited) of
                true -> false;
                _ ->
                    array:put(Index, true, Visited),
                    if
                        X == Dx andalso Y == Dy -> true;
                        true ->
                            Directions = [[-1, 0], [1, 0], [0, -1], [0, 1]],
                            lists:any(fun(Dir) ->
                                NewX = X + Dir[0],
                                NewY = Y + Dir[1],
                                dfs([NewX, NewY], [Dx, Dy], Maze, Visited, Rows, Cols)
                            end, Directions)
                    end
            end
    end.