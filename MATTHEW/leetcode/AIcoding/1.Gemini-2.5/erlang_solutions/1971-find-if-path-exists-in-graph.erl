-module(solution).
-export([valid_path/3]).

valid_path(N, Edges, Source, Destination) ->
    if Source == Destination ->
        true;
    true ->
        Graph = build_graph(N, Edges),
        bfs(Graph, Source, Destination)
    end.

build_graph(N, Edges) ->
    InitialGraph = maps:from_list([{I, []} || I <- lists:seq(0, N-1)]),
    lists:foldl(
        fun([U, V], AccGraph) ->
            AccGraph1 = maps:update_with(U, fun(List) -> [V | List] end, [V], AccGraph),
            maps:update_with(V, fun(List) -> [U | List] end, [U], AccGraph1)
        end,
        InitialGraph,
        Edges
    ).

bfs(Graph, Source, Destination) ->
    Queue = queue:in(Source, queue:new()),
    Visited = sets:add_element(Source, sets:new()),
    bfs_loop(Graph, Destination, Queue, Visited).

bfs_loop(_Graph, _Destination, Queue, _Visited) when queue:is_empty(Queue) ->
    false;
bfs_loop(Graph, Destination, Queue, Visited) ->
    {value, CurrentNode, NewQueue} = queue:out(Queue),
    if CurrentNode == Destination ->
        true;
    true ->
        Neighbors = maps:get(CurrentNode, Graph, []),
        {UpdatedQueue, UpdatedVisited} = lists:foldl(
            fun(Neighbor, {AccQueue, AccVisited}) ->
                if not sets:is_element(Neighbor, AccVisited) ->
                    {queue:in(Neighbor, AccQueue), sets:add_element(Neighbor, AccVisited)};
                true ->
                    {AccQueue, AccVisited}
                end
            end,
            {NewQueue, Visited},
            Neighbors
        ),
        bfs_loop(Graph, Destination, UpdatedQueue, UpdatedVisited)
    end.