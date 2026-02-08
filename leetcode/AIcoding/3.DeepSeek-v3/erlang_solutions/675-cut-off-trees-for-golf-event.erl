-module(solution).
-export([cutOffTree/1]).

cutOffTree(Forest) ->
    Trees = lists:sort([{H, X, Y} || {Row, X} <- lists:zip(Forest, lists:seq(0, length(Forest) - 1)),
                                     {H, Y} <- lists:zip(Row, lists:seq(0, length(Row) - 1)),
                                     H > 1]),
    cutOffTree(Forest, Trees, 0, 0, 0).

cutOffTree(_, [], _, _, Steps) -> Steps;
cutOffTree(Forest, [{_, X, Y} | Trees], Sx, Sy, Steps) ->
    case bfs(Forest, Sx, Sy, X, Y) of
        -1 -> -1;
        Dist -> cutOffTree(Forest, Trees, X, Y, Steps + Dist)
    end.

bfs(Forest, Sx, Sy, Tx, Ty) ->
    Rows = length(Forest),
    Cols = length(hd(Forest)),
    Visited = sets:from_list([{Sx, Sy}]),
    Queue = queue:from_list([{Sx, Sy, 0}]),
    bfs_loop(Forest, Queue, Visited, Tx, Ty, Rows, Cols).

bfs_loop(Forest, Queue, Visited, Tx, Ty, Rows, Cols) ->
    case queue:out(Queue) of
        {empty, _} -> -1;
        {{value, {X, Y, Dist}}, NewQueue} ->
            if
                X =:= Tx andalso Y =:= Ty -> Dist;
                true ->
                    Directions = [{-1, 0}, {1, 0}, {0, -1}, {0, 1}],
                    NewVisited = Visited,
                    NewQueue1 = lists:foldl(
                        fun({Dx, Dy}, Acc) ->
                            Nx = X + Dx,
                            Ny = Y + Dy,
                            case Nx >= 0 andalso Nx < Rows andalso Ny >= 0 andalso Ny < Cols of
                                true ->
                                    case sets:is_element({Nx, Ny}, NewVisited) of
                                        false ->
                                            case lists:nth(Nx + 1, Forest) of
                                                Row when is_list(Row) ->
                                                    case lists:nth(Ny + 1, Row) of
                                                        0 -> Acc;
                                                        _ ->
                                                            NewVisited1 = sets:add_element({Nx, Ny}, NewVisited),
                                                            queue:in({Nx, Ny, Dist + 1}, Acc)
                                                    end;
                                                _ -> Acc
                                            end;
                                        true -> Acc
                                    end;
                                false -> Acc
                            end
                        end,
                        NewQueue,
                        Directions
                    ),
                    bfs_loop(Forest, NewQueue1, NewVisited, Tx, Ty, Rows, Cols)
            end
    end.