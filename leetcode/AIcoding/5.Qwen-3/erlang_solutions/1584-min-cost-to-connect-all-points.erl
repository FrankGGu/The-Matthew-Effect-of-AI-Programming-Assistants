-module(min_cost_to_connect_all_points).
-export([minCostConnectPoints/1]).

minCostConnectPoints(Points) ->
    N = length(Points),
    Edges = generate_edges(Points, 0, []),
    Prim(Edges, N, 1, [true], 0).

generate_edges([], _, Acc) -> Acc;
generate_edges([P | Rest], I, Acc) ->
    generate_edges(Rest, I + 1, generate_edges_helper(P, Rest, I, Acc)).

generate_edges_helper(_, [], _, Acc) -> Acc;
generate_edges_helper(P, [Q | Rest], I, Acc) ->
    Dist = abs(P -- Q),
    generate_edges_helper(P, Rest, I, [{I, lists:nth(1, Q), lists:nth(2, Q), Dist} | Acc]).

Prim(Edges, N, Count, Visited, Cost) when Count == N -> Cost;
Prim(Edges, N, Count, Visited, Cost) ->
    {MinEdge, NewEdges} = find_min_edge(Edges, Visited),
    [U, V, D] = MinEdge,
    NewVisited = lists:keystore(V, 1, Visited, {V, true}),
    Prim(NewEdges, N, Count + 1, NewVisited, Cost + D).

find_min_edge(Edges, Visited) ->
    find_min_edge(Edges, Visited, nil, 0).

find_min_edge([], _, MinEdge, MinDist) ->
    {MinEdge, []};
find_min_edge([{U, V, D} | Rest], Visited, MinEdge, MinDist) ->
    case is_connected(U, Visited) andalso not is_connected(V, Visited) of
        true ->
            if D < MinDist orelse MinEdge == nil ->
                find_min_edge(Rest, Visited, {U, V, D}, D);
            true ->
                find_min_edge(Rest, Visited, MinEdge, MinDist)
            end;
        false ->
            find_min_edge(Rest, Visited, MinEdge, MinDist)
    end.

is_connected(Node, Visited) ->
    case lists:keysearch(Node, 1, Visited) of
        {value, {Node, _}} -> true;
        _ -> false
    end.