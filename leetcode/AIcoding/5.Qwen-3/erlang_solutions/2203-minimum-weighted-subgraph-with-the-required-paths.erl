-module(minimum_weighted_subgraph_with_required_paths).
-export([min_total_weight/2]).

min_total_weight(Edges, Paths) ->
    Graph = build_graph(Edges),
    Nodes = lists:usort(lists:flatten([[A, B] || [A, B, _] <- Edges])),
    {Distances, _} = dijkstra(Graph, Nodes),
    Total = calculate_total(Distances, Paths),
    Total.

build_graph(Edges) ->
    lists:foldl(fun([A, B, W], Acc) ->
        Acc#{A => maps:get(A, Acc, []) ++ [{B, W}], B => maps:get(B, Acc, []) ++ [{A, W}]}
    end, #{}, Edges).

dijkstra(Graph, Nodes) ->
    Initial = maps:from_list([{N, infinity} || N <- Nodes]),
    {_, Distances} = lists:foldl(fun(Node, {Visited, Dist}) ->
        case maps:get(Node, Dist, infinity) of
            infinity -> {Visited, Dist};
            _ ->
                {NewVisited, NewDist} = update_distances(Node, Graph, Visited, Dist),
                {NewVisited, NewDist}
        end
    end, {maps:new(), Initial}, Nodes),
    {maps:values(Distances), Distances}.

update_distances(Node, Graph, Visited, Dist) ->
    Neighbors = maps:get(Node, Graph, []),
    lists:foldl(fun({Neighbor, Weight}, {VisitedAcc, DistAcc}) ->
        CurrentDist = maps:get(Neighbor, DistAcc, infinity),
        NewDist = maps:get(Node, DistAcc, infinity) + Weight,
        if
            NewDist < CurrentDist ->
                {VisitedAcc, DistAcc#{Neighbor => NewDist}};
            true ->
                {VisitedAcc, DistAcc}
        end
    end, {Visited, Dist}, Neighbors).

calculate_total(Distances, Paths) ->
    lists:sum([get_path_weight(Path, Distances) || Path <- Paths]).

get_path_weight([Start | Rest], Distances) ->
    get_path_weight(Rest, Start, Distances, 0).

get_path_weight([], _, _, Total) ->
    Total;
get_path_weight([Next | Rest], Current, Distances, Total) ->
    Weight = maps:get(Current, Distances, infinity),
    if
        Weight == infinity -> infinity;
        true -> get_path_weight(Rest, Next, Distances, Total + Weight)
    end.