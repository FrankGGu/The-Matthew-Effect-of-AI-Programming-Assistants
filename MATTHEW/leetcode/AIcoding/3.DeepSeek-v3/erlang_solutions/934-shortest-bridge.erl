-module(solution).
-export([shortest_bridge/1]).

shortest_bridge(Grid) ->
    {N, M} = {length(Grid), length(hd(Grid))},
    {X, Y} = find_first_island(Grid, N, M),
    Queue = queue:new(),
    Visited = sets:new(),
    Queue1 = queue:in({X, Y, 0}, Queue),
    Visited1 = sets:add_element({X, Y}, Visited),
    {Queue2, Visited2} = dfs(Grid, N, M, Queue1, Visited1),
    bfs(Grid, N, M, Queue2, Visited2).

find_first_island(Grid, N, M) ->
    find_first_island(Grid, N, M, 0, 0).

find_first_island(Grid, N, M, I, J) when I < N ->
    case J < M of
        true ->
            case lists:nth(J + 1, lists:nth(I + 1, Grid)) of
                1 -> {I, J};
                _ -> find_first_island(Grid, N, M, I, J + 1)
            end;
        false -> find_first_island(Grid, N, M, I + 1, 0)
    end;
find_first_island(_, _, _, _, _) -> {-1, -1}.

dfs(Grid, N, M, Queue, Visited) ->
    case queue:is_empty(Queue) of
        true -> {Queue, Visited};
        false ->
            {{value, {X, Y, _}}, Queue1} = queue:out(Queue),
            Neighbors = [{X + 1, Y}, {X - 1, Y}, {X, Y + 1}, {X, Y - 1}],
            {Queue2, Visited1} = lists:foldl(
                fun({NX, NY}, {Q, V}) ->
                    case is_valid(NX, NY, N, M) andalso 
                         not sets:is_element({NX, NY}, V) andalso 
                         lists:nth(NY + 1, lists:nth(NX + 1, Grid)) == 1 of
                        true ->
                            {queue:in({NX, NY, 0}, Q), sets:add_element({NX, NY}, V)};
                        false -> {Q, V}
                    end
                end,
                {Queue1, Visited},
                Neighbors
            ),
            dfs(Grid, N, M, Queue2, Visited1)
    end.

bfs(Grid, N, M, Queue, Visited) ->
    case queue:is_empty(Queue) of
        true -> 0;
        false ->
            {{value, {X, Y, Dist}}, Queue1} = queue:out(Queue),
            Neighbors = [{X + 1, Y}, {X - 1, Y}, {X, Y + 1}, {X, Y - 1}],
            case lists:any(
                fun({NX, NY}) ->
                    is_valid(NX, NY, N, M) andalso 
                    not sets:is_element({NX, NY}, Visited) andalso 
                    lists:nth(NY + 1, lists:nth(NX + 1, Grid)) == 1
                end,
                Neighbors
            ) of
                true -> Dist;
                false ->
                    {Queue2, Visited1} = lists:foldl(
                        fun({NX, NY}, {Q, V}) ->
                            case is_valid(NX, NY, N, M) andalso 
                                 not sets:is_element({NX, NY}, V) of
                                true ->
                                    {queue:in({NX, NY, Dist + 1}, Q), sets:add_element({NX, NY}, V)};
                                false -> {Q, V}
                            end
                        end,
                        {Queue1, Visited},
                        Neighbors
                    ),
                    bfs(Grid, N, M, Queue2, Visited1)
            end
    end.

is_valid(X, Y, N, M) ->
    X >= 0 andalso X < N andalso Y >= 0 andalso Y < M.