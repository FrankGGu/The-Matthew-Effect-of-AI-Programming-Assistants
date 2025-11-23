-module(max_score_of_node_sequence).
-export([maxScore/1]).

maxScore(Graph) ->
    N = length(Graph),
    MaxScore = -1,
    lists:foldl(fun(I, Acc) ->
        lists:foldl(fun(J, Acc2) ->
            if I /= J ->
                Path1 = dijkstra(Graph, I),
                Path2 = dijkstra(Graph, J),
                Score = lists:nth(I+1, Path1) + lists:nth(J+1, Path2),
                max(Acc2, Score);
            true -> Acc2
            end
        end, Acc, lists:seq(0, N-1))
    end, MaxScore, lists:seq(0, N-1)).

dijkstra(Graph, Start) ->
    N = length(Graph),
    Dist = array:new(N, {default, infinity}),
    Dist1 = array:set(Start, 0, Dist),
    Queue = erlang:queue:from_list(lists:seq(0, N-1)),
    dijkstra_loop(Graph, Dist1, Queue).

dijkstra_loop(_, Dist, []) ->
    array:to_list(Dist);
dijkstra_loop(Graph, Dist, Queue) ->
    {MinNode, NewQueue} = find_min_node(Dist, Queue),
    Neighbors = lists:nth(MinNode+1, Graph),
    UpdatedDist = update_neighbors(Graph, MinNode, Dist, Neighbors),
    dijkstra_loop(Graph, UpdatedDist, NewQueue).

find_min_node(Dist, Queue) ->
    lists:foldl(fun(Node, {MinNode, MinDist, Acc}) ->
        D = array:get(Node, Dist),
        if D < MinDist -> {Node, D, Acc};
           true -> {MinNode, MinDist, [Node | Acc]}
        end
    end, {0, infinity, []}, erlang:queue:to_list(Queue)).

update_neighbors(_, _, Dist, []) ->
    Dist;
update_neighbors(Graph, Node, Dist, [Neighbor | Rest]) ->
    CurrentDist = array:get(Node, Dist),
    NeighborDist = array:get(Neighbor, Dist),
    NewDist = if CurrentDist + 1 < NeighborDist -> array:set(Neighbor, CurrentDist + 1, Dist);
               true -> Dist
             end,
    update_neighbors(Graph, Node, NewDist, Rest).