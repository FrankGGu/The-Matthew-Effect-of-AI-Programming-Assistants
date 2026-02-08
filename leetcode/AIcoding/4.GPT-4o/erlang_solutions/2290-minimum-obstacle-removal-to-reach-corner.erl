-module(solution).
-export([minimum_obstacles/1]).

minimum_obstacles(Grid) ->
    N = length(Grid),
    M = length(hd(Grid)),
    Start = {0, 0, 0},
    End = {N - 1, M - 1},
    Queue = queue:new(),
    Queue1 = queue:in(Start, Queue),
    Visited = maps:empty(),
    bfs(Queue1, Visited, Grid, End).

bfs(Queue, Visited, Grid, End) ->
    case queue:out(Queue) of
        {empty, _} -> -1;
        {{value, {X, Y, D}}, Rest} ->
            if
                {X, Y} = End -> D;
                maps:is_key({X, Y}, Visited) -> bfs(Rest, Visited, Grid, End);
                true ->
                    Visited1 = maps:put({X, Y}, D, Visited),
                    Neighbors = get_neighbors(X, Y, Grid),
                    NewQueue = lists:foldl(fun({NX, NY}, Q) ->
                                                D1 = D + (if Grid[NX][NY] == 1 -> 1; true -> 0 end),
                                                queue:in({NX, NY, D1}, Q)
                                            end, Rest, Neighbors),
                    bfs(NewQueue, Visited1, Grid, End)
            end
    end.

get_neighbors(X, Y, Grid) ->
    N = length(Grid),
    M = length(hd(Grid)),
    lists:filter(fun({NX, NY}) -> NX >= 0, NY >= 0, NX < N, NY < M end,
                  [{X + 1, Y}, {X - 1, Y}, {X, Y + 1}, {X, Y - 1}]).