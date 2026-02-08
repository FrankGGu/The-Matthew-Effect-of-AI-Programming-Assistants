-module(solution).
-export([solve/4]).

-define(INF, 1_000_000_000). %% A sufficiently large number for infinity

solve(N, Edges, Start, End) ->
    %% Build adjacency list: #{Node => [{Neighbor, Weight}]}
    %% Assuming an undirected graph. If the graph is directed, remove the line adding the reverse edge.
    Adj = lists:foldl(
        fun([U, V, W], Acc) ->
            Map1 = maps:update_with(U, fun(List) -> [{V, W} | List] end, [{V, W}], Acc),
            maps:update_with(V, fun(List) -> [{U, W} | List] end, [{U, W}], Map1)
        end,
        maps:empty(),
        Edges
    ),

    %% Initialize distances: #{Node => Distance}, all to INF except Start=0
    Distances0 = maps:from_list([{I, ?INF} || I <- lists:seq(1, N)]),
    Distances = maps:put(Start, 0, Distances0),

    %% Priority Queue: gb_trees stores {Distance, Node}
    %% Key is Distance, Value is Node. gb_trees maintains sorted order by key.
    PQ = gb_trees:insert(0, Start, gb_trees:empty()),

    dijkstra(PQ, Distances, Adj, End).

dijkstra(PQ, Distances, Adj, End) ->
    case gb_trees:is_empty(PQ) of
        true ->
            %% All reachable nodes processed or no path found to End
            maps:get(End, Distances);
        false ->
            {{MinDist, U}, NewPQ} = gb_trees:take_min(PQ),

            %% If a shorter path to U has already been finalized (processed), skip this stale entry
            case MinDist > maps:get(U, Distances) of
                true ->
                    dijkstra(NewPQ, Distances, Adj, End);
                false ->
                    %% Process neighbors of U
                    Neighbors = maps:get(U, Adj, []), %% Get neighbors, default to empty list if U has no edges

                    {UpdatedDistances, UpdatedPQ} = lists:foldl(
                        fun({V, Weight}, {AccDistances, AccPQ}) ->
                            CurrentDistV = maps:get(V, AccDistances), %% All nodes 1..N are initialized in Distances
                            NewDistV = MinDist + Weight,
                            if NewDistV < CurrentDistV ->
                                   {maps:put(V, NewDistV, AccDistances), gb_trees:insert(NewDistV, V, AccPQ)};
                               true ->
                                   {AccDistances, AccPQ}
                            end
                        end,
                        {Distances, NewPQ},
                        Neighbors
                    ),
                    dijkstra(UpdatedPQ, UpdatedDistances, Adj, End)
            end
    end.