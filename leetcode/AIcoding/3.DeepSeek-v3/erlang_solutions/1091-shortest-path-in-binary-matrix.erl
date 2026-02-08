-module(solution).
-export([shortest_path_binary_matrix/1]).

shortest_path_binary_matrix(Grid) ->
    N = length(Grid),
    case lists:nth(1, lists:nth(1, Grid)) of
        1 -> -1;
        0 ->
            Queue = queue:in({1, 1, 1}, queue:new()),
            Visited = sets:add_element({1, 1}, sets:new()),
            bfs(Grid, Queue, Visited, N)
    end.

bfs(Grid, Queue, Visited, N) ->
    case queue:is_empty(Queue) of
        true -> -1;
        false ->
            {{value, {X, Y, Steps}}, NewQueue} = queue:out(Queue),
            if
                X =:= N andalso Y =:= N -> Steps;
                true ->
                    Directions = [{-1, -1}, {-1, 0}, {-1, 1}, {0, -1}, {0, 1}, {1, -1}, {1, 0}, {1, 1}],
                    NewVisited = lists:foldl(
                        fun({Dx, Dy}, AccVisited) ->
                            NX = X + Dx,
                            NY = Y + Dy,
                            if
                                NX >= 1, NX =< N, NY >= 1, NY =< N ->
                                    case lists:nth(NY, lists:nth(NX, Grid)) of
                                        0 ->
                                            case sets:is_element({NX, NY}, AccVisited) of
                                                false ->
                                                    sets:add_element({NX, NY}, AccVisited);
                                                true ->
                                                    AccVisited
                                            end;
                                        _ ->
                                            AccVisited
                                    end;
                                true ->
                                    AccVisited
                            end
                        end,
                        Visited,
                        Directions
                    ),
                    UpdatedQueue = lists:foldl(
                        fun({Dx, Dy}, AccQueue) ->
                            NX = X + Dx,
                            NY = Y + Dy,
                            if
                                NX >= 1, NX =< N, NY >= 1, NY =< N ->
                                    case lists:nth(NY, lists:nth(NX, Grid)) of
                                        0 ->
                                            case sets:is_element({NX, NY}, NewVisited) of
                                                false ->
                                                    queue:in({NX, NY, Steps + 1}, AccQueue);
                                                true ->
                                                    AccQueue
                                            end;
                                        _ ->
                                            AccQueue
                                    end;
                                true ->
                                    AccQueue
                            end
                        end,
                        NewQueue,
                        Directions
                    ),
                    bfs(Grid, UpdatedQueue, NewVisited, N)
            end
    end.