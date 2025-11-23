-module(solution).
-export([num_restricted_paths/2]).

num_restricted_paths(Edges, Restrict) ->
    Graph = build_graph(Edges),
    Nodes = lists:usort(lists:flatten(Edges)),
    LastNode = lists:last(Nodes),
    {Distances, _} = dijkstra(Graph, hd(Nodes), 0, #{}),
    SortedNodes = lists:sort(fun(A, B) -> Distances[A] < Distances[B] end, Nodes),
    Paths = paths_from_first_to_last(Graph, SortedNodes, LastNode, #{}),
    maps:get(LastNode, Paths).

build_graph(Edges) ->
    lists:foldl(fun({U, V}, Acc) ->
        Acc#{U => [V | maps:get(U, Acc, [])], V => [U | maps:get(V, Acc, [])]}
    end, #{}, Edges).

dijkstra(Graph, Start, _Acc, Distances) ->
    case maps:size(Distances) of
        Size when Size == maps:size(Graph) -> {Distances, Graph};
        _ ->
            {MinNode, MinDist} = find_min_node(Distances, Graph),
            NewDistances = maps:put(MinNode, MinDist, Distances),
            Neighbors = maps:get(MinNode, Graph),
            UpdatedDistances = lists:foldl(fun(Node, D) ->
                Current = maps:get(Node, D, infinity),
                New = min(Current, MinDist + 1),
                maps:put(Node, New, D)
            end, NewDistances, Neighbors),
            dijkstra(Graph, Start, 0, UpdatedDistances)
    end.

find_min_node(Distances, Graph) ->
    lists:foldl(fun(Node, {MinNode, MinDist}) ->
        Dist = maps:get(Node, Distances, infinity),
        if Dist < MinDist -> {Node, Dist};
           true -> {MinNode, MinDist}
        end
    end, {hd(maps:keys(Graph)), infinity}, maps:keys(Graph)).

paths_from_first_to_last(_, _, _, _) -> #{};

paths_from_first_to_last(Graph, [Node | Rest], Last, Memo) ->
    case Node of
        Last -> maps:put(Last, 1, Memo);
        _ ->
            Count = lists:foldl(fun(Neighbor, Acc) ->
                if Neighbor == Last -> Acc + 1;
                   true -> Acc + maps:get(Neighbor, Memo, 0)
                end
            end, 0, maps:get(Node, Graph)),
            paths_from_first_to_last(Graph, Rest, Last, maps:put(Node, Count, Memo))
    end.