-module(minimum_score_of_a_path_between_two_cities).
-export([minScore/2]).

minScore(1, 1) -> 0;
minScore(N, Edges) ->
    Graph = build_graph(N, Edges),
    {_, Score} = dijkstra(Graph, 1, N),
    Score.

build_graph(N, Edges) ->
    lists:foldl(fun({A, B, W}, Acc) ->
        Acc#{A => [{B, W} | maps:get(A, Acc, [])],
             B => [{A, W} | maps:get(B, Acc, [])]}
    end, #{}, Edges).

dijkstra(Graph, Start, End) ->
    Dist = maps:from_list([{I, infinity} || I <- lists:seq(1, maps:size(Graph))]),
    Dist1 = maps:update(Start, 0, Dist),
    Queue = queue:from_list([{0, Start}]),
    dijkstra_loop(Graph, Dist1, Queue, End).

dijkstra_loop(_, Dist, Queue, _) when queue:is_empty(Queue) ->
    {maps:get(1, Dist), maps:get(1, Dist)};
dijkstra_loop(Graph, Dist, Queue, End) ->
    {CurrentDist, CurrentNode} = queue:out(Queue),
    case CurrentDist > maps:get(CurrentNode, Dist) of
        true -> dijkstra_loop(Graph, Dist, Queue, End);
        false ->
            Neighbors = maps:get(CurrentNode, Graph, []),
            {NewDist, NewQueue} = update_neighbors(Graph, Dist, Queue, CurrentNode, Neighbors),
            dijkstra_loop(Graph, NewDist, NewQueue, End)
    end.

update_neighbors(_, Dist, Queue, _, []) ->
    {Dist, Queue};
update_neighbors(Graph, Dist, Queue, Node, [{Neighbor, Weight} | Rest]) ->
    NewDist = maps:get(Node, Dist) + Weight,
    case NewDist < maps:get(Neighbor, Dist) of
        true ->
            NewDistMap = maps:update(Neighbor, NewDist, Dist),
            NewQueue = queue:in({NewDist, Neighbor}, Queue),
            update_neighbors(Graph, NewDistMap, NewQueue, Node, Rest);
        false ->
            update_neighbors(Graph, Dist, Queue, Node, Rest)
    end.