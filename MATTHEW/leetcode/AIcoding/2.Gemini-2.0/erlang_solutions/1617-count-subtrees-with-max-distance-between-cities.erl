-module(count_subtrees).
-export([count_subtrees/2]).

count_subtrees(N, Edges) ->
    Graph = create_graph(N, Edges),
    Result = lists:map(fun(D) -> count_subtrees_with_distance(N, Graph, D) end, lists:seq(1, N - 1)),
    Result.

create_graph(N, Edges) ->
    create_graph_helper(N, Edges, lists:seq(1, N), []).

create_graph_helper(0, _, _, Acc) ->
    Acc;
create_graph_helper(N, Edges, [Node | Rest], Acc) ->
    Neighbors = lists:foldl(fun([U, V], Acc2) ->
                                   if U =:= Node ->
                                       [V | Acc2];
                                   true ->
                                       if V =:= Node ->
                                           [U | Acc2];
                                       true ->
                                           Acc2
                                       end
                                   end
                               end, [], Edges),
    create_graph_helper(N - 1, Edges, Rest, [{Node, Neighbors} | Acc]).

count_subtrees_with_distance(N, Graph, Distance) ->
    count_subtrees_with_distance_helper(N, Graph, Distance, 0, 1).

count_subtrees_with_distance_helper(N, Graph, Distance, Count, SubtreeSize) when SubtreeSize > math:pow(2, N) -1 ->
    Count;
count_subtrees_with_distance_helper(N, Graph, Distance, Count, SubtreeSize) ->
    Vertices = get_vertices_from_subtree(SubtreeSize, N),
    Subgraph = create_subgraph(Graph, Vertices),
    if is_connected(Subgraph, Vertices) ->
        MaxDistance = max_distance(Subgraph, Vertices, 0),
        if MaxDistance =:= Distance ->
            count_subtrees_with_distance_helper(N, Graph, Distance, Count + 1, SubtreeSize + 1);
        true ->
            count_subtrees_with_distance_helper(N, Graph, Distance, Count, SubtreeSize + 1)
        end;
    true ->
        count_subtrees_with_distance_helper(N, Graph, Distance, Count, SubtreeSize + 1)
    end.

get_vertices_from_subtree(SubtreeSize, N) ->
    Vertices = [],
    get_vertices_from_subtree_helper(SubtreeSize, N, Vertices, 1).

get_vertices_from_subtree_helper(SubtreeSize, N, Vertices, Vertex) when Vertex > N ->
    Vertices;
get_vertices_from_subtree_helper(SubtreeSize, N, Vertices, Vertex) ->
    if (SubtreeSize band (1 bsl (Vertex - 1))) =:= (1 bsl (Vertex - 1)) ->
        get_vertices_from_subtree_helper(SubtreeSize, N, [Vertex | Vertices], Vertex + 1);
    true ->
        get_vertices_from_subtree_helper(SubtreeSize, N, Vertices, Vertex + 1)
    end.

create_subgraph(Graph, Vertices) ->
    lists:filter(fun({Node, _}) -> lists:member(Node, Vertices) end, Graph).

is_connected(Subgraph, Vertices) ->
    case Vertices of
        [] ->
            true;
        [Start | _] ->
            Visited = bfs(Subgraph, Start, Vertices, []),
            lists:sort(Visited) =:= lists:sort(Vertices)
    end.

bfs(Subgraph, Start, TargetVertices, Visited) ->
    bfs_helper([Start], Subgraph, TargetVertices, Visited, []).

bfs_helper([], _, _, Visited, Queue) ->
    Visited;
bfs_helper([Node | Rest], Subgraph, TargetVertices, Visited, Queue) ->
    case lists:member(Node, Visited) of
        true ->
            bfs_helper(Rest, Subgraph, TargetVertices, Visited, Queue);
        false ->
            Neighbors = get_neighbors(Subgraph, Node),
            ValidNeighbors = lists:filter(fun(Neighbor) -> lists:member(Neighbor, TargetVertices) end, Neighbors),
            NewQueue = lists:foldl(fun(Neighbor, Acc) ->
                                         case lists:member(Neighbor, Visited) of
                                             true ->
                                                 Acc;
                                             false ->
                                                 [Neighbor | Acc]
                                         end
                                     end, Queue, ValidNeighbors),
            bfs_helper(Rest ++ lists:reverse(NewQueue), Subgraph, TargetVertices, [Node | Visited], [])
    end.

get_neighbors(Subgraph, Node) ->
    case lists:keyfind(Node, 1, Subgraph) of
        {_, Neighbors} ->
            Neighbors;
        false ->
            []
    end.

max_distance(Subgraph, Vertices, InitialDistance) ->
    max_distance_helper(Subgraph, Vertices, InitialDistance, lists:seq(1, length(Vertices))).

max_distance_helper(_, _, MaxDistance, []) ->
    MaxDistance;
max_distance_helper(Subgraph, Vertices, MaxDistance, [Index | Rest]) ->
    Start = lists:nth(Index, Vertices),
    Distances = dijkstra(Subgraph, Start, Vertices),
    NewMaxDistance = lists:foldl(fun(Distance, Acc) ->
                                      if Distance > Acc ->
                                          Distance;
                                      true ->
                                          Acc
                                      end
                                  end, MaxDistance, Distances),
    max_distance_helper(Subgraph, Vertices, NewMaxDistance, Rest).

dijkstra(Subgraph, Start, Vertices) ->
    dijkstra_helper(Subgraph, Start, Vertices, [], [{V, infinity} || V <- Vertices], []).

dijkstra_helper(_, _, [], Distances, _,_) ->
    Distances;
dijkstra_helper(Subgraph, Start, Vertices, Visited, Distances, Queue) ->
    case Queue of
        [] ->
            % Initialize Queue with Start Vertex
            NewQueue = [{Start,0}],
            dijkstra_helper(Subgraph, Start, Vertices, [], Distances, NewQueue);
        [{U, Du} | RestQueue] ->
            case lists:member(U, Visited) of
                true ->
                    dijkstra_helper(Subgraph, Start, Vertices, Visited, Distances, RestQueue);
                false ->
                    UpdatedDistances = lists:map(fun({V, Dv}) ->
                                                      Neighbors = get_neighbors(Subgraph, U),
                                                      if lists:member(V, Neighbors) ->
                                                          if Du + 1 < Dv ->
                                                              {V, Du + 1};
                                                          true ->
                                                              {V, Dv}
                                                          end;
                                                      true ->
                                                          {V, Dv}
                                                      end
                                                  end, Distances),
                    NewQueue = lists:foldl(fun({V, Dv}, Acc) ->
                                                 case lists:member(V, Visited) of
                                                     true ->
                                                         Acc;
                                                     false ->
                                                         case lists:keyfind(V, 1, Queue) of
                                                             false ->
                                                                 [{V, Dv} | Acc];
                                                             {_, ExistingDistance} ->
                                                                 if Dv < ExistingDistance ->
                                                                     [{V, Dv} | Acc];
                                                                 true ->
                                                                     Acc
                                                                 end
                                                         end
                                                 end
                                             end, RestQueue, UpdatedDistances),
                    dijkstra_helper(Subgraph, Start, Vertices, [U | Visited], UpdatedDistances, lists:sort(fun({_, D1}, {_, D2}) -> D1 < D2 end, NewQueue))
            end
    end.

infinity() ->
    100000000.