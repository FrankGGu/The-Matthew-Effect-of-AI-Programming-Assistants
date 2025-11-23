-module(solution).
-export([guard_castle/1]).

guard_castle(Grid) ->
    M = length(Grid),
    N = length(hd(Grid)),
    GridList = [list_to_tuple(Row) || Row <- Grid],
    {Sx, Sy} = find_portal(GridList, M, N, 'S'),
    {Tx, Ty} = find_portal(GridList, M, N, 'T'),
    case bfs(GridList, M, N, Sx, Sy, Tx, Ty) of
        -1 -> -1;
        Steps -> Steps
    end.

find_portal(Grid, M, N, Portal) ->
    find_portal(Grid, M, N, Portal, 0, 0).

find_portal(Grid, M, N, Portal, I, J) when I < M ->
    Row = element(I + 1, list_to_tuple(Grid)),
    case lists:nth(J + 1, tuple_to_list(Row)) of
        Portal -> {I, J};
        _ -> find_portal(Grid, M, N, Portal, I, J + 1)
    end;
find_portal(Grid, M, N, Portal, I, _) when I < M ->
    find_portal(Grid, M, N, Portal, I + 1, 0);
find_portal(_, _, _, _, _, _) ->
    {-1, -1}.

bfs(Grid, M, N, Sx, Sy, Tx, Ty) ->
    Directions = [{-1, 0}, {1, 0}, {0, -1}, {0, 1}],
    Queue = queue:in({Sx, Sy, 0}, queue:new()),
    Visited = sets:add_element({Sx, Sy}, sets:new()),
    bfs_loop(Grid, M, N, Tx, Ty, Directions, Queue, Visited).

bfs_loop(Grid, M, N, Tx, Ty, Directions, Queue, Visited) ->
    case queue:out(Queue) of
        {empty, _} -> -1;
        {{value, {X, Y, Steps}}, Q} ->
            if
                X =:= Tx andalso Y =:= Ty -> Steps;
                true ->
                    NewQueue = lists:foldl(
                        fun({Dx, Dy}, AccQ) ->
                            Nx = X + Dx,
                            Ny = Y + Dy,
                            case is_valid(Nx, Ny, M, N) andalso
                                 not sets:is_element({Nx, Ny}, Visited) andalso
                                 is_passable(element(Nx + 1, list_to_tuple(Grid)), Ny + 1) of
                                true ->
                                    NewVisited = sets:add_element({Nx, Ny}, Visited),
                                    queue:in({Nx, Ny, Steps + 1}, AccQ);
                                false -> AccQ
                            end
                        end,
                        Q,
                        Directions
                    ),
                    bfs_loop(Grid, M, N, Tx, Ty, Directions, NewQueue, Visited)
            end
    end.

is_valid(X, Y, M, N) ->
    X >= 0 andalso X < M andalso Y >= 0 andalso Y < N.

is_passable(Row, Y) ->
    Cell = element(Y, Row),
    Cell =/= '#' andalso Cell =/= 'C'.