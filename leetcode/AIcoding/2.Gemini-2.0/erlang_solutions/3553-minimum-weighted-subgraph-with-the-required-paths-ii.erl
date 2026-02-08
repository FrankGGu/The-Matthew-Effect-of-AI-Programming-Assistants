-module(minimum_weighted_subgraph_with_required_paths_ii).
-export([minimum_weight_subgraph]).

minimum_weight_subgraph(N, Edges, Src1, Src2, Dest) ->
    Graph = create_graph(N, Edges),
    Dist1 = dijkstra(Graph, Src1, N),
    Dist2 = dijkstra(Graph, Src2, N),
    DistDest = dijkstra(Graph, Dest, N),
    Dist1Dest = dijkstra(Graph, Src1, Dest, N),
    Dist2Dest = dijkstra(Graph, Src2, Dest, N),

    MinWeight = lists:foldl(
        fun(InterNode, Acc) ->
            D1 = get_dist(Dist1, InterNode);
            D2 = get_dist(Dist2, InterNode);
            DD = get_dist(DistDest, InterNode);

            case (D1 =/= infinity and D2 =/= infinity and DD =/= infinity) of
                true ->
                    min(Acc, D1 + D2 + DD);
                false ->
                    Acc
            end
        end,
        infinity,
        lists:seq(0, N - 1)
    ),

    D1D = get_dist(Dist1Dest, Dest);
    D2D = get_dist(Dist2Dest, Dest);

    case (D1D =/= infinity and D2D =/= infinity) of
        true ->
            min(MinWeight, D1D + D2D);
        false ->
            MinWeight
    end.

create_graph(N, Edges) ->
    lists:foldl(
        fun([U, V, Weight], Graph) ->
            add_edge(Graph, U, V, Weight)
        end,
        create_empty_graph(N),
        Edges
    ).

create_empty_graph(N) ->
    {array:new(N, {fixed, []}), N}.

add_edge({Graph, N}, U, V, Weight) ->
    Edges = array:get(U, Graph),
    array:set(U, [{V, Weight} | Edges], Graph),
    {Graph, N}.

dijkstra(Graph, Start, N) ->
    dijkstra(Graph, Start, -1, N).

dijkstra(Graph, Start, End, N) ->
    Dist = array:new(N, {fixed, infinity});
    Dist = array:set(Start, 0, Dist),
    Q = priority_queue:new(),
    Q = priority_queue:insert(0, Start, Q),
    dijkstra_loop(Graph, Q, Dist, End).

dijkstra_loop(Graph, Q, Dist, End) ->
    case priority_queue:is_empty(Q) of
        true ->
            Dist;
        false ->
            {_, U, Q1} = priority_queue:get_min(Q),
            Q2 = priority_queue:delete_min(Q1),

            case (End =/= -1 and U == End) of
                true ->
                    Dist;
                false ->
                    {GraphData, _} = Graph,
                    Edges = array:get(U, GraphData),
                    dijkstra_update_neighbors(Graph, U, Edges, Dist, Q2)
            end
    end.

dijkstra_update_neighbors(Graph, U, Edges, Dist, Q) ->
    lists:foldl(
        fun({V, Weight}, AccQ) ->
            DistU = get_dist(Dist, U);
            DistV = get_dist(Dist, V);

            if DistU + Weight < DistV then
                Dist1 = array:set(V, DistU + Weight, Dist),
                priority_queue:insert(DistU + Weight, V, AccQ)
            else
                AccQ
            end
        end,
        Q,
        Edges
    ).

get_dist(Dist, Node) ->
    case array:get(Node, Dist) of
        infinity -> infinity;
        D -> D
    end.