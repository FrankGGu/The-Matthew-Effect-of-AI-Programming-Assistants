-module(maze).
-export([has_path/3]).

has_path(Maze, Start, Destination) ->
    Rows = length(Maze),
    Cols = length(hd(Maze)),
    Visited = array:new({1, Rows}, {default, array:new({1, Cols}, {default, false})}),
    dfs(Maze, Start, Destination, Visited, 0, 0).

dfs(_, _, _, _, X, Y) when X < 0; X >= length(Maze); Y < 0; Y >= length(hd(Maze)) ->
    false;
dfs(Maze, Start, Destination, Visited, X, Y) ->
    [SX, SY] = Start,
    [DX, DY] = Destination,
    if
        X == DX andalso Y == DY -> true;
        true ->
            case array:get({X+1, Y+1}, Visited) of
                true -> false;
                _ ->
                    array:set({X+1, Y+1}, true, Visited),
                    Directions = [[-1,0],[1,0],[0,-1],[0,1]],
                    lists:any(fun(Dir) ->
                        [DX, DY] = Dir,
                        dfs(Maze, Start, Destination, Visited, X + DX, Y + DY)
                    end, Directions)
            end
    end.