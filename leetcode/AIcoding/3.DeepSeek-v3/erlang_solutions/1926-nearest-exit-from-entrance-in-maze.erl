-module(solution).
-export([nearest_exit/2]).

nearest_exit(Maze, Entrance) ->
    {Er, Ec} = Entrance,
    Rows = length(Maze),
    Cols = length(hd(Maze)),
    Directions = [{-1, 0}, {1, 0}, {0, -1}, {0, 1}],
    Queue = queue:in({Er, Ec, 0}, queue:new()),
    Visited = sets:add_element({Er, Ec}, sets:new()),
    bfs(Maze, Queue, Visited, Directions, Rows, Cols).

bfs(Maze, Queue, Visited, Directions, Rows, Cols) ->
    case queue:out(Queue) of
        {empty, _} -> -1;
        {{value, {R, C, Steps}}, Q} ->
            case (R =:= 0 orelse R =:= Rows - 1 orelse C =:= 0 orelse C =:= Cols - 1) andalso {R, C} =/= hd(queue:to_list(queue:in({0, 0}, queue:new()))) of
                true -> Steps;
                false ->
                    NewQ = lists:foldl(fun({Dr, Dc}, AccQ) ->
                        NewR = R + Dr,
                        NewC = C + Dc,
                        case NewR >= 0 andalso NewR < Rows andalso NewC >= 0 andalso NewC < Cols andalso
                             lists:nth(NewR + 1, Maze) /= "+" andalso not sets:is_element({NewR, NewC}, Visited) of
                            true ->
                                NewVisited = sets:add_element({NewR, NewC}, Visited),
                                queue:in({NewR, NewC, Steps + 1}, AccQ);
                            false -> AccQ
                        end
                    end, Q, Directions),
                    bfs(Maze, NewQ, Visited, Directions, Rows, Cols)
            end
    end.