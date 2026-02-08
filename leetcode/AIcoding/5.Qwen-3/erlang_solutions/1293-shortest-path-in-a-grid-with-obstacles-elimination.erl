-module(solution).
-export([shortest_path/1]).

shortest_path(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    Visited = maps:new(),
    Queue = queue:from_list([{0, 0, 0, 0}]),
    shortest_path(Grid, Rows, Cols, Visited, Queue).

shortest_path(_, _, _, Visited, Queue) when queue:is_empty(Queue) ->
    -1;

shortest_path(Grid, Rows, Cols, Visited, Queue) ->
    {X, Y, K, Dist} = queue:out(Queue),
    case {X, Y} of
        {Rows-1, Cols-1} ->
            Dist;
        _ ->
            case maps:get({X, Y, K}, Visited, false) of
                true ->
                    shortest_path(Grid, Rows, Cols, Visited, queue:in(Queue, {X, Y, K, Dist}));
                false ->
                    NewVisited = maps:put({X, Y, K}, true, Visited),
                    Directions = [{-1,0},{1,0},{0,-1},{0,1}],
                    NewQueue = lists:foldl(fun({DX, DY}, Q) ->
                        NX = X + DX,
                        NY = Y + DY,
                        if
                            NX >= 0, NX < Rows, NY >= 0, NY < Cols ->
                                case grid_value(Grid, NX, NY) of
                                    1 ->
                                        if K > 0 ->
                                            queue:in(Q, {NX, NY, K-1, Dist+1});
                                           true ->
                                            Q
                                        end;
                                    0 ->
                                        queue:in(Q, {NX, NY, K, Dist+1})
                                end;
                            true ->
                                Q
                        end
                    end, Queue, Directions),
                    shortest_path(Grid, Rows, Cols, NewVisited, NewQueue)
            end
    end.

grid_value(Grid, X, Y) ->
    lists:nth(X+1, Grid) -- [H|_] -> H; [] -> 0.