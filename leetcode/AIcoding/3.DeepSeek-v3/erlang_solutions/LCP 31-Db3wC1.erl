-module(solution).
-export([escape_maze/1]).

escape_maze(Grid) ->
    M = length(Grid),
    N = length(hd(Grid)),
    Visited = sets:new(),
    Queue = queue:in({0, 0, 0, false}, queue:new()),
    bfs(Grid, M, N, Visited, Queue).

bfs(Grid, M, N, Visited, Queue) ->
    case queue:out(Queue) of
        {empty, _} -> false;
        {{value, {X, Y, Steps, Used}}, NewQueue} ->
            if
                X =:= M - 1 andalso Y =:= N - 1 -> true;
                true ->
                    Key = {X, Y, Used},
                    case sets:is_element(Key, Visited) of
                        true -> bfs(Grid, M, N, Visited, NewQueue);
                        false ->
                            NewVisited = sets:add_element(Key, Visited),
                            Directions = [{-1, 0}, {1, 0}, {0, -1}, {0, 1}],
                            UpdatedQueue = lists:foldl(fun({Dx, Dy}, Acc) ->
                                NX = X + Dx,
                                NY = Y + Dy,
                                if
                                    NX >= 0 andalso NX < M andalso NY >= 0 andalso NY < N ->
                                        Cell = lists:nth(NY + 1, lists:nth(NX + 1, Grid)),
                                        case Cell of
                                            0 -> queue:in({NX, NY, Steps + 1, Used}, Acc);
                                            1 when not Used -> queue:in({NX, NY, Steps + 1, true}, Acc);
                                            _ -> Acc
                                        end;
                                    true -> Acc
                                end
                            end, NewQueue, Directions),
                            bfs(Grid, M, N, NewVisited, UpdatedQueue)
                    end
            end
    end.