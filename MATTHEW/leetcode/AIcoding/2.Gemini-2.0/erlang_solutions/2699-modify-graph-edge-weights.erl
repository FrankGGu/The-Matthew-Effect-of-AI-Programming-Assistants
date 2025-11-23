-module(modify_graph_edge_weights).
-export([modifiedGraphEdges/3]).

modifiedGraphEdges(N, Edges, Destination) ->
    {Adj, EdgeIndices} = build_adj(N, Edges),
    Dist0 = dijkstra(N, Adj, 0, Destination),
    MissingEdges = find_missing_edges(Edges),
    {Adj1, NewEdges} = fill_missing_edges(Adj, Edges, MissingEdges, Destination - Dist0),
    Dist1 = dijkstra(N, Adj1, 0, Destination),

    case Dist1 == Destination of
        true ->
            NewEdges;
        false ->
            [[-1,-1] || _ <- Edges]
    end.

build_adj(N, Edges) ->
    build_adj(N, Edges, [], []).

build_adj(N, [], Adj, EdgeIndices) ->
    {lists:reverse([[] || _ <- lists:seq(1, N)]) ++ Adj, lists:reverse(EdgeIndices)};
build_adj(N, [[U, V, W] | Rest], Adj, EdgeIndices) ->
    Index = length(Adj),
    NewAdj = update_adj(Adj, U, V, W, Index),
    build_adj(N, Rest, NewAdj, [Index | EdgeIndices]).

update_adj(Adj, U, V, W, Index) ->
    update_adj(Adj, U, V, W, Index, 0).

update_adj(Adj, U, V, W, Index, Acc) ->
    case Acc of
        U - 1 ->
            lists:nth(U, Adj) ++ [{V - 1, W, Index}];
        _ ->
            lists:nth(U, Adj)
    end,
    case Acc of
        V - 1 ->
            lists:nth(V, Adj) ++ [{U - 1, W, Index}];
        _ ->
            lists:nth(V, Adj)
    end,
    NewAdjU = case Acc of
                 U - 1 ->
                     lists:nth(U, Adj) ++ [{V - 1, W, Index}];
                 _ ->
                     lists:nth(U, Adj)
             end,
    NewAdjV = case Acc of
                 V - 1 ->
                     lists:nth(V, Adj) ++ [{U - 1, W, Index}];
                 _ ->
                     lists:nth(V, Adj)
             end,
    lists:nth(U, Adj) -> NewAdjU;
    lists:nth(V, Adj) -> NewAdjV,
    lists:nth(U, lists:seq(1,length(Adj))) ->
        case U - 1 of
            Acc ->
                lists:nth(U, Adj) ++ [{V - 1, W, Index}];
            _ ->
                lists:nth(U, Adj)
        end;
    lists:nth(V, lists:seq(1,length(Adj))) ->
        case V - 1 of
            Acc ->
                lists:nth(V, Adj) ++ [{U - 1, W, Index}];
            _ ->
                lists:nth(V, Adj)
        end,
    lists:update_element(U, Adj, NewAdjU),
    lists:update_element(V, Adj, NewAdjV),
    lists:update_element(U, lists:seq(1,length(Adj)), NewAdjU),
    lists:update_element(V, lists:seq(1,length(Adj)), NewAdjV),
    NewAdj = lists:update_element(U, lists:seq(1,length(Adj)),NewAdjU),
    lists:update_element(V, NewAdj,NewAdjV),
    NewAdj.

find_missing_edges(Edges) ->
    find_missing_edges(Edges, [], 0).

find_missing_edges([], MissingEdges, _) ->
    lists:reverse(MissingEdges);
find_missing_edges([[_, _, -1] | Rest], MissingEdges, Index) ->
    find_missing_edges(Rest, [Index | MissingEdges], Index + 1);
find_missing_edges([_ | Rest], MissingEdges, Index) ->
    find_missing_edges(Rest, MissingEdges, Index + 1).

fill_missing_edges(Adj, Edges, MissingEdges, Diff) ->
    fill_missing_edges(Adj, Edges, MissingEdges, Diff, []).

fill_missing_edges(Adj, Edges, [], _, NewEdges) ->
    {Adj, NewEdges};
fill_missing_edges(Adj, Edges, [Index | Rest], Diff, NewEdges) ->
    [U, V, _] = lists:nth(Index + 1, Edges),
    W = min(1000, max(1, Diff)),

    NewAdj = update_adj(Adj, U, V, W, Index),
    NewEdges1 = update_edges(Edges, Index, W),

    fill_missing_edges(NewAdj, NewEdges1, Rest, Diff - W, [lists:nth(Index+1,NewEdges1) | NewEdges]).

update_edges(Edges, Index, W) ->
    lists:update_element(Index + 1, Edges, [lists:nth(1, lists:nth(Index+1, Edges)), lists:nth(2, lists:nth(Index+1, Edges)), W]).

dijkstra(N, Adj, Start, Destination) ->
    dijkstra(N, Adj, [{0, Start}], lists:duplicate(N, infinity), Destination).

dijkstra(N, Adj, [], Distances, _) ->
    lists:nth(N, Distances);
dijkstra(N, Adj, [{Distance, Node} | Rest], Distances, Destination) ->
    case lists:nth(Node + 1, Distances) < Distance of
        true ->
            dijkstra(N, Adj, Rest, Distances, Destination);
        false ->
            NewDistances = lists:update_element(Node + 1, Distances, Distance),
            Neighbors = lists:nth(Node + 1, Adj),
            NewQueue = merge_queue(Rest, Neighbors, Distance, NewDistances),
            dijkstra(N, Adj, NewQueue, NewDistances, Destination)
    end.

merge_queue(Queue, Neighbors, Distance, Distances) ->
    merge_queue(Queue, Neighbors, Distance, Distances, []).

merge_queue(Queue, [], _, _, Acc) ->
    sort_queue(lists:reverse(Acc) ++ Queue);
merge_queue(Queue, [{Neighbor, Weight, _} | Rest], Distance, Distances, Acc) ->
    NewDistance = Distance + Weight,
    case lists:nth(Neighbor + 1, Distances) < NewDistance of
        true ->
            merge_queue(Queue, Rest, Distance, Distances, Acc);
        false ->
            merge_queue(Queue, Rest, Distance, Distances, [{NewDistance, Neighbor} | Acc])
    end.

sort_queue(Queue) ->
    lists:sort(fun({A,_}, {B,_}) -> A < B end, Queue).

infinity ->
    1000000000.