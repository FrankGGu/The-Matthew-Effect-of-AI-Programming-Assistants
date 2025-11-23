-module(solution).
-export([find_safe_path/1]).

find_safe_path(Grid) ->
    {M, N} = {length(Grid), length(lists:nth(1, Grid))},
    Visited = sets:new(),
    Queue = queue:new(),
    case lists:nth(1, lists:nth(1, Grid)) of
        0 ->
            queue:in({1, 1, 0}, Queue),
            sets:add_element({1, 1}, Visited);
        _ ->
            ok
    end,
    bfs(Grid, M, N, Queue, Visited).

bfs(Grid, M, N, Queue, Visited) ->
    case queue:is_empty(Queue) of
        true ->
            -1;
        false ->
            {{value, {X, Y, Steps}}, NewQueue} = queue:out(Queue),
            if
                X =:= M, Y =:= N ->
                    Steps;
                true ->
                    Directions = [{-1, 0}, {1, 0}, {0, -1}, {0, 1}],
                    NewVisited = lists:foldl(
                        fun({Dx, Dy}, AccVisited) ->
                            NewX = X + Dx,
                            NewY = Y + Dy,
                            if
                                NewX >= 1, NewX =< M, NewY >= 1, NewY =< N ->
                                    case lists:nth(NewY, lists:nth(NewX, Grid)) of
                                        0 ->
                                            case sets:is_element({NewX, NewY}, AccVisited) of
                                                false ->
                                                    sets:add_element({NewX, NewY}, AccVisited),
                                                    queue:in({NewX, NewY, Steps + 1}, NewQueue),
                                                    AccVisited;
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
                    bfs(Grid, M, N, NewQueue, NewVisited)
            end
    end.