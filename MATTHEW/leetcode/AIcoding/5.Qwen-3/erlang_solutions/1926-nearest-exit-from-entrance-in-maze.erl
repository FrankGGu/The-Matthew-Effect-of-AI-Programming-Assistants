-module(nearest_exit).
-export([nearestExit/2]).

nearestExit(Maze, Entrance) ->
    {Rows, Cols} = {length(Maze), length(hd(Maze))},
    {StartRow, StartCol} = Entrance,
    Queue = queue:from_list([{StartRow, StartCol, 0}]),
    Visited = gb_sets:from_list([{StartRow, StartCol}]),
    bfs(Maze, Rows, Cols, Queue, Visited).

bfs(_Maze, _Rows, _Cols, Queue, _Visited) when queue:is_empty(Queue) ->
    -1;

bfs(Maze, Rows, Cols, Queue, Visited) ->
    {{value, {R, C, Dist}}, NewQueue} = queue:out(Queue),
    case isExit(Maze, R, C, Rows, Cols) of
        true -> Dist;
        false ->
            Neighbors = getNeighbors(R, C, Rows, Cols),
            NewVisited = lists:foldl(fun({NR, NC}, Acc) ->
                                            if
                                                not gb_sets:is_in({NR, NC}, Acc) andalso (lists:nth(NR + 1, Maze) -- [32] == []) -> 
                                                    gb_sets:add({NR, NC}, Acc);
                                                true -> Acc
                                            end
                                        end, Visited, Neighbors),
            NewQueue2 = lists:foldl(fun({NR, NC}, Q) ->
                                            if
                                                not gb_sets:is_in({NR, NC}, NewVisited) ->
                                                    queue:in({NR, NC, Dist + 1}, Q);
                                                true -> Q
                                            end
                                        end, NewQueue, Neighbors),
            bfs(Maze, Rows, Cols, NewQueue2, NewVisited)
    end.

getNeighbors(R, C, Rows, Cols) ->
    Directions = [{-1, 0}, {1, 0}, {0, -1}, {0, 1}],
    lists:filter(fun({DR, DC}) ->
                     NR = R + DR,
                     NC = C + DC,
                     NR >= 0 andalso NR < Rows andalso NC >= 0 andalso NC < Cols
                 end, Directions).

isExit(Maze, R, C, Rows, Cols) ->
    IsBorder = (R == 0 orelse R == Rows - 1 orelse C == 0 orelse C == Cols - 1),
    IsNotEntrance = not (R == hd(Entrace) andalso C == hd(tl(Entrace))),
    IsNotWall = lists:nth(R + 1, Maze) -- [32] == [],
    IsBorder andalso IsNotEntrance andalso IsNotWall.