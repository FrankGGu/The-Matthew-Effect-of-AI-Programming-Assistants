-module(grid_teleportation_traversal).
-export([min_time/1]).

min_time(Grid) ->
    N = length(Grid),
    M = length(hd(Grid)),
    Visited = array:new({N, M}, {default, false}),
    Q = queue:from_list([{0, 0, 0, -1}]),
    min_time_loop(Q, Visited, Grid, N, M).

min_time_loop(Q, Visited, Grid, N, M) ->
    case queue:out(Q) of
        {empty, _} -> -1;
        {{value, {X, Y, Time, Dir}}, NewQ} ->
            if
                X < 0 orelse X >= N orelse Y < 0 orelse Y >= M -> min_time_loop(NewQ, Visited, Grid, N, M);
                array:get({X, Y}, Visited) -> min_time_loop(NewQ, Visited, Grid, N, M);
                true ->
                    array:set({X, Y}, true, Visited),
                    Case = grid_cell(Grid, X, Y),
                    if
                        X == N-1 andalso Y == M-1 -> Time;
                        true ->
                            NextQ = add_next(Q, NewQ, X, Y, Time, Dir, Case, N, M),
                            min_time_loop(NextQ, Visited, Grid, N, M)
                    end
            end
    end.

add_next(Q, Acc, X, Y, Time, Dir, Case, N, M) ->
    Directions = [{-1, 0}, {1, 0}, {0, -1}, {0, 1}],
    lists:foldl(fun({DX, DY}, AccIn) ->
        NX = X + DX,
        NY = Y + DY,
        if
            NX >= 0 andalso NX < N andalso NY >= 0 andalso NY < M ->
                case array:get({NX, NY}, Acc) of
                    false -> queue:in({NX, NY, Time + 1, Dir}, AccIn);
                    true -> AccIn
                end;
            true -> AccIn
        end
    end, Q, Directions).

grid_cell(Grid, X, Y) ->
    lists:nth(X + 1, Grid) -- [Y + 1].