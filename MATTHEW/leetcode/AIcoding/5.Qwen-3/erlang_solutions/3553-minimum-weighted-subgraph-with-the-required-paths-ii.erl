-module(minimum_weighted_subgraph_with_required_paths_ii).
-export([minTotalWeight/2]).

minTotalWeight(Edges, Path) ->
    Graph = build_graph(Edges),
    Nodes = lists:usort(lists:flatten([[A, B] || [A, B, _] <- Edges])),
    RequiredPaths = get_required_paths(Path),
    {MinWeight, _} = dijkstra(Graph, Nodes, RequiredPaths),
    MinWeight.

build_graph(Edges) ->
    lists:foldl(fun([A, B, W], Acc) ->
                    Acc#{A => [{B, W} | maps:get(A, Acc, [])],
                         B => [{A, W} | maps:get(B, Acc, [])]}
                end, #{}, Edges).

get_required_paths([]) -> [];
get_required_paths([H | T]) ->
    [lists:seq(H, lists:last(T))] ++ get_required_paths(T).

dijkstra(Graph, Nodes, RequiredPaths) ->
    {Distances, _} = lists:foldl(fun(Node, {Dist, Visited}) ->
                                     Dist1 = maps:put(Node, infinity, Dist),
                                     {Dist1, Visited}
                                 end, #{}, Nodes),
    {_, FinalDist} = lists:foldl(fun({Start, End}, {Dist, Visited}) ->
                                     {NewDist, _} = dijkstra_helper(Graph, Start, End, Dist, Visited),
                                     {NewDist, Visited}
                                 end, {Distances, []}, RequiredPaths),
    {lists:sum(maps:values(FinalDist)), FinalDist}.

dijkstra_helper(_, _, _, Dist, _) when Dist =:= undefined -> {Dist, []};
dijkstra_helper(Graph, Start, End, Dist, Visited) ->
    {Dist1, Visited1} = dijkstra_helper(Graph, Start, End, Dist, Visited, []),
    {Dist1, Visited1}.

dijkstra_helper(_, _, _, Dist, Visited, []) -> {Dist, Visited};
dijkstra_helper(Graph, Start, End, Dist, Visited, Queue) ->
    {MinNode, MinDist} = find_min_node(Queue, Dist),
    if
        MinNode =:= End -> {Dist, Visited ++ [MinNode]};
        true ->
            NewVisited = Visited ++ [MinNode],
            NewQueue = remove_node(MinNode, Queue),
            Neighbors = maps:get(MinNode, Graph, []),
            UpdatedDist = update_distances(Neighbors, MinNode, MinDist, Dist),
            dijkstra_helper(Graph, Start, End, UpdatedDist, NewVisited, NewQueue)
    end.

find_min_node([], _) -> {undefined, 0};
find_min_node([{Node, D} | _], Dist) -> {Node, maps:get(Node, Dist)}.

remove_node(_, []) -> [];
remove_node(Node, [{N, D} | T]) when N =:= Node -> remove_node(Node, T);
remove_node(Node, [H | T]) -> [H | remove_node(Node, T)].

update_distances([], _, _, Dist) -> Dist;
update_distances([{Neighbor, Weight} | T], CurrentNode, CurrentDist, Dist) ->
    NewDist = CurrentDist + Weight,
    Dist1 = case maps:get(Neighbor, Dist, infinity) of
                Infinity when Infinity =:= infinity -> maps:put(Neighbor, NewDist, Dist);
                Existing -> if NewDist < Existing -> maps:put(Neighbor, NewDist, Dist); true -> Dist end
            end,
    update_distances(T, CurrentNode, CurrentDist, Dist1).