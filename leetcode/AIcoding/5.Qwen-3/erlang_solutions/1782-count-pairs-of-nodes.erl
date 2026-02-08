-module(count_pairs_of_nodes).
-export([countPairs/2]).

countPairs(Edges, Limit) ->
    Nodes = lists:seq(1, length(Edges) + 1),
    Graph = build_graph(Edges),
    Count = 0,
    lists:foldl(fun(Node, Acc) -> count_pairs_from_node(Node, Graph, Limit, Acc) end, Count, Nodes).

build_graph(Edges) ->
    maps:from_list([ {N, []} || N <- lists:seq(1, length(Edges) + 1) ]) ++ 
    lists:foldl(fun({A, B}, Acc) -> 
        maps:update(A, [B | maps:get(A, Acc)], Acc),
        maps:update(B, [A | maps:get(B, Acc)], Acc)
    end, maps:from_list([ {N, []} || N <- lists:seq(1, length(Edges) + 1) ]), Edges).

count_pairs_from_node(Node, Graph, Limit, Acc) ->
    Visited = sets:new(),
    Distances = bfs(Node, Graph, Visited),
    lists:foldl(fun({Other, D}, A) -> 
        if D < Limit -> A + 1;
           true -> A
        end
    end, Acc, maps:to_list(Distances)).

bfs(Node, Graph, Visited) ->
    Queue = queue:in({Node, 0}, queue:new()),
    bfs_loop(Queue, Visited, maps:new()).

bfs_loop(Q, Visited, Distances) ->
    case queue:out(Q) of
        {empty, _} -> Distances;
        {{value, {Current, Distance}}, NewQ} ->
            case sets:is_element(Current, Visited) of
                true -> bfs_loop(NewQ, Visited, Distances);
                false ->
                    NewVisited = sets:add_element(Current, Visited),
                    NewDistances = maps:put(Current, Distance, Distances),
                    Neighbors = maps:get(Current, Graph),
                    NewQueue = lists:foldl(fun(Neighbor, QAcc) -> 
                        queue:in({Neighbor, Distance + 1}, QAcc)
                    end, NewQ, Neighbors),
                    bfs_loop(NewQueue, NewVisited, NewDistances)
            end
    end.