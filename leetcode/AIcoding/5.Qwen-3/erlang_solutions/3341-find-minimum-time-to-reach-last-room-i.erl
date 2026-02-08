-module(solution).
-export([minTimeToReachLastRoom/1]).

minTimeToReachLastRoom(Rooms) ->
    N = length(Rooms),
    M = length(hd(Rooms)),
    {_, _, Result} = bfs(Rooms, N, M),
    Result.

bfs(Rooms, N, M) ->
    Dir = [{-1,0},{1,0},{0,-1},{0,1}],
    Visited = array:new({N, M}, {default, -1}),
    Queue = queue:from_list([{0, 0, 0}]),
    array:set({0, 0}, 0, Visited),
    bfs_loop(Queue, Dir, Rooms, N, M, Visited).

bfs_loop(Queue, _Dir, _Rooms, N, M, Visited) when queue:is_empty(Queue) ->
    {N-1, M-1, array:get({N-1, M-1}, Visited)};
bfs_loop(Queue, Dir, Rooms, N, M, Visited) ->
    {{X, Y, Time}, NewQueue} = queue:out(Queue),
    case {X, Y} of
        {N-1, M-1} -> {X, Y, Time};
        _ ->
            lists:foreach(fun({DX, DY}) ->
                NX = X + DX,
                NY = Y + DY,
                if
                    NX >= 0, NX < N, NY >= 0, NY < M ->
                        NextTime = Time + 1,
                        case array:get({NX, NY}, Visited) of
                            -1 ->
                                array:set({NX, NY}, NextTime, Visited),
                                bfs_loop(queue:in({NX, NY, NextTime}, NewQueue), Dir, Rooms, N, M, Visited);
                            _ ->
                                ok
                        end;
                    true ->
                        ok
                end
            end, Dir)
    end.