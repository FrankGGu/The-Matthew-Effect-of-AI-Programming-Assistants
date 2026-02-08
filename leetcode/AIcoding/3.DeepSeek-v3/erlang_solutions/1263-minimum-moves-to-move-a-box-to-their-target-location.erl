-module(solution).
-export([min_push_box/1]).

min_push_box(Grid) ->
    {M, N} = {length(Grid), length(hd(Grid))},
    {Bx, By, Tx, Ty, Px, Py} = find_positions(Grid, M, N),
    Visited = sets:new(),
    Queue = queue:in({Bx, By, Px, Py, 0}, queue:new()),
    bfs(Grid, M, N, Tx, Ty, Queue, Visited).

find_positions(Grid, M, N) ->
    find_positions(Grid, M, N, 0, 0, undefined, undefined, undefined, undefined, undefined, undefined).

find_positions(_, M, N, I, _, Bx, By, Tx, Ty, Px, Py) when I >= M -> {Bx, By, Tx, Ty, Px, Py};
find_positions(Grid, M, N, I, J, Bx, By, Tx, Ty, Px, Py) when J >= N ->
    find_positions(Grid, M, N, I + 1, 0, Bx, By, Tx, Ty, Px, Py);
find_positions(Grid, M, N, I, J, Bx, By, Tx, Ty, Px, Py) ->
    Char = lists:nth(J + 1, lists:nth(I + 1, Grid)),
    NewPos =
        case Char of
            $B -> {I, J, Tx, Ty, Px, Py};
            $T -> {Bx, By, I, J, Px, Py};
            $S -> {Bx, By, Tx, Ty, I, J};
            _ -> {Bx, By, Tx, Ty, Px, Py}
        end,
    {NewBx, NewBy, NewTx, NewTy, NewPx, NewPy} = NewPos,
    find_positions(Grid, M, N, I, J + 1, NewBx, NewBy, NewTx, NewTy, NewPx, NewPy).

bfs(Grid, M, N, Tx, Ty, Queue, Visited) ->
    case queue:out(Queue) of
        {empty, _} -> -1;
        {{value, {Bx, By, Px, Py, Pushes}}, NewQueue} ->
            case {Bx, By} of
                {Tx, Ty} -> Pushes;
                _ ->
                    Key = {Bx, By, Px, Py},
                    case sets:is_element(Key, Visited) of
                        true -> bfs(Grid, M, N, Tx, Ty, NewQueue, Visited);
                        false ->
                            NewVisited = sets:add_element(Key, Visited),
                            NextStates = generate_next_states(Grid, M, N, Bx, By, Px, Py, Pushes),
                            UpdatedQueue = lists:foldl(fun(State, Q) -> queue:in(State, Q) end, NewQueue, NextStates),
                            bfs(Grid, M, N, Tx, Ty, UpdatedQueue, NewVisited)
                    end
            end
    end.

generate_next_states(Grid, M, N, Bx, By, Px, Py, Pushes) ->
    Directions = [{-1, 0}, {1, 0}, {0, -1}, {0, 1}],
    lists:filtermap(
        fun({Dx, Dy}) ->
            Nx = Px + Dx,
            Ny = Py + Dy,
            if
                Nx >= 0, Nx < M, Ny >= 0, Ny < N ->
                    case lists:nth(Ny + 1, lists:nth(Nx + 1, Grid)) of
                        $# -> false;
                        _ ->
                            if
                                Nx =:= Bx, Ny =:= By ->
                                    NBx = Bx + Dx,
                                    NBy = By + Dy,
                                    if
                                        NBx >= 0, NBx < M, NBy >= 0, NBy < N ->
                                            case lists:nth(NBy + 1, lists:nth(NBx + 1, Grid)) of
                                                $# -> false;
                                                _ -> {true, {NBx, NBy, Nx, Ny, Pushes + 1}}
                                            end;
                                        true -> false
                                    end;
                                true -> {true, {Bx, By, Nx, Ny, Pushes}}
                            end
                    end;
                true -> false
            end
        end,
        Directions
    ).