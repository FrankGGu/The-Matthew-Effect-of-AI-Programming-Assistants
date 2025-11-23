-module(minimum_weighted_subgraph).
-export([minimum_weight_subgraph/4]).

minimum_weight_subgraph(N, Edges, Src1, Src2, Dest) ->
    Graph = lists:foldl(fun({U, V, W}, Acc) ->
                                 maps:update_with(U, fun(L) -> [{V, W} | L] end, [{V, W}], Acc)
                             end, #{}, Edges),
    {Dist1, _} = dijkstra(N, Graph, Src1),
    {Dist2, _} = dijkstra(N, Graph, Src2),
    {DistDest, _} = dijkstra(N, reverse_graph(Graph), Dest),

    PathCosts = [maps:get(I, Dist1, infinity) + maps:get(I, Dist2, infinity) + maps:get(I, DistDest, infinity) || I <- lists:seq(0, N - 1)],

    MinCost = lists:min(PathCosts),
    if MinCost >= infinity then
        -1
    else
        MinCost
    end.

dijkstra(N, Graph, Start) ->
    Dist = maps:from_list([{I, infinity} || I <- lists:seq(0, N - 1)]).
    Dist1 = maps:put(Start, 0, Dist),
    Q = priority_queue:new(),
    Q1 = priority_queue:insert(Start, 0, Q),

    dijkstra_helper(Graph, Dist1, Q1).

dijkstra_helper(Graph, Dist, Q) ->
    case priority_queue:is_empty(Q) of
        true ->
            {Dist, Graph};
        false ->
            {U, D, Q2} = priority_queue:delete_min(Q),
            Neighbors = maps:get(U, Graph, []),
            NewDist = lists:foldl(fun({V, W}, AccDist) ->
                                         NewDistance = D + W,
                                         OldDistance = maps:get(V, AccDist, infinity),
                                         if NewDistance < OldDistance then
                                             Q3 = priority_queue:insert(V, NewDistance, Q2),
                                             maps:put(V, NewDistance, AccDist)
                                         else
                                             AccDist
                                         end
                                     end, Dist, Neighbors),
            dijkstra_helper(Graph, NewDist, Q2)
    end.

reverse_graph(Graph) ->
    lists:foldl(fun({U, Neighbors}, Acc) ->
                         lists:foldl(fun({V, W}, Acc2) ->
                                             maps:update_with(V, fun(L) -> [{U, W} | L] end, [{U, W}], Acc2)
                                         end, Acc, Neighbors)
                     end, #{}, maps:to_list(Graph)).

-define(infinity, 1000000000000000).