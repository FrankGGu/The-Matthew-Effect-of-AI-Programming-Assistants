-module(solution).
-export([shortest_path/3]).

shortest_path(Grid, K) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    Visited = sets:new(),
    Queue = queue:in({0, 0, 0, K}, queue:new()),
    bfs(Grid, Rows, Cols, Queue, Visited).

bfs(Grid, Rows, Cols, Queue, Visited) ->
    case queue:out(Queue) of
        {empty, _} -> -1;
        {{value, {X, Y, Steps, K}}, Q} ->
            if
                X =:= Rows - 1 andalso Y =:= Cols - 1 -> Steps;
                true ->
                    Key = {X, Y, K},
                    case sets:is_element(Key, Visited) of
                        true -> bfs(Grid, Rows, Cols, Q, Visited);
                        false ->
                            NewVisited = sets:add_element(Key, Visited),
                            NewQueue = lists:foldl(
                                fun({Dx, Dy}, Acc) ->
                                    NX = X + Dx,
                                    NY = Y + Dy,
                                    if
                                        NX >= 0, NX < Rows, NY >= 0, NY < Cols ->
                                            NK = case lists:nth(NY + 1, lists:nth(NX + 1, Grid)) of
                                                1 -> K - 1;
                                                0 -> K
                                            end,
                                            if
                                                NK >= 0 -> queue:in({NX, NY, Steps + 1, NK}, Acc);
                                                true -> Acc
                                            end;
                                        true -> Acc
                                    end
                                end,
                                Q,
                                [{0, 1}, {1, 0}, {0, -1}, {-1, 0}]
                            ),
                            bfs(Grid, Rows, Cols, NewQueue, NewVisited)
                    end
            end
    end.