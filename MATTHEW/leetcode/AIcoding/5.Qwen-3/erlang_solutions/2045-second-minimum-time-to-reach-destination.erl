-module(solution).
-export([secondMinimum/2]).

secondMinimum(Edges, Node) ->
    Graph = build_graph(Edges),
    {Min1, Min2} = dijkstra(Graph, Node),
    Min2.

build_graph(Edges) ->
    lists:foldl(fun({U, V}, Acc) ->
        Acc#{U => [V | maps:get(U, Acc, [])], V => [U | maps:get(V, Acc, [])]}
    end, #{}, Edges).

dijkstra(Graph, Start) ->
    Dist = maps:from_list([{N, infinity} || N <- maps:keys(Graph)]),
    Dist1 = maps:update(Start, 0, Dist),
    {_, _, Min1, Min2} = dijkstra_helper(Graph, Start, Dist1, []),
    {Min1, Min2}.

dijkstra_helper(_, _, _, []) -> {0, 0};
dijkstra_helper(Graph, Start, Dist, Queue) ->
    {MinNode, Dist1} = find_min_node(Dist, Queue),
    if
        MinNode == Start andalso maps:get(MinNode, Dist1) == 0 ->
            {_, Dist2} = process_neighbors(Graph, MinNode, Dist1, []),
            dijkstra_helper(Graph, Start, Dist2, []);
        true ->
            {Min1, Min2} = get_min_values(Dist1, Start),
            {Min1, Min2}
    end.

find_min_node(Dist, Queue) ->
    lists:foldl(fun({Node, _}, {CurrentNode, CurrentDist}) ->
        D = maps:get(Node, Dist),
        if
            D < CurrentDist -> {Node, Dist};
            true -> {CurrentNode, CurrentDist}
        end
    end, {hd(Queue), Dist}, Queue).

process_neighbors(_, _, Dist, []) -> {Dist, Dist};
process_neighbors(Graph, Node, Dist, Queue) ->
    Neighbors = maps:get(Node, Graph, []),
    lists:foldl(fun(Neighbor, {AccDist, AccQueue}) ->
        NewDist = maps:get(Neighbor, AccDist),
        CurrentDist = maps:get(Node, AccDist),
        if
            NewDist == infinity ->
                AccDist1 = maps:update(Neighbor, CurrentDist + 1, AccDist),
                {AccDist1, [{Neighbor, CurrentDist + 1} | AccQueue]};
            NewDist == CurrentDist + 1 ->
                {AccDist, AccQueue};
            true ->
                {AccDist, AccQueue}
        end
    end, {Dist, Queue}, Neighbors).

get_min_values(Dist, Start) ->
    Values = lists:sort([maps:get(N, Dist) || N <- maps:keys(Dist)]),
    Min1 = lists:nth(1, Values),
    Min2 = lists:nth(2, Values),
    {Min1, Min2}.