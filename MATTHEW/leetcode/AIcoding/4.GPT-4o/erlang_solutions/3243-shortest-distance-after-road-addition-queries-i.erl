-module(solution).
-export([shortest_distance/3]).

shortest_distance(N, roads, queries) ->
    Graph = build_graph(N, roads),
    lists:map(fun(Query) -> query_distance(Graph, Query) end, queries).

build_graph(N, Roads) ->
    Graph = lists:duplicate(N + 1, []),
    foldl(fun({X, Y, D}, Acc) ->
        Acc1 = lists:update_element(X + 1, [{Y + 1, D} | lists:nth(X + 1, Acc)], Acc),
        lists:update_element(Y + 1, [{X + 1, D} | lists:nth(Y + 1, Acc)], Acc1)
    end, Graph, Roads).

query_distance(Graph, {U, V}) ->
    case dijkstra(Graph, U + 1, V + 1) of
        undefined -> -1;
        Distance -> Distance
    end.

dijkstra(Graph, Start, End) ->
    Distances = lists:duplicate(length(Graph), infinity),
    Distances1 = lists:replace_element(Start, 0, Distances),
    dijkstra_helper(Graph, [{0, Start}], Distances1, End).

dijkstra_helper(_, [], Distances, _) -> 
    case lists:find(fun(X) -> X =:= infinity end, Distances) of
        false -> lists:nth(End, Distances);
        true -> undefined
    end;
dijkstra_helper(Graph, [{Cost, Node} | Rest], Distances, End) ->
    if
        Cost > lists:nth(Node, Distances) -> 
            dijkstra_helper(Graph, Rest, Distances, End);
        true ->
            NewDistances = lists:foldl(fun({Neighbor, Weight}, Acc) ->
                NewCost = Cost + Weight,
                case lists:nth(Neighbor, Acc) of
                    OldCost when NewCost < OldCost -> lists:replace_element(Neighbor, NewCost, Acc);
                    _ -> Acc
                end
            end, Distances, Graph(Node)),
            dijkstra_helper(Graph, Rest ++ [{NewCost, Neighbor} || {Neighbor, NewCost} <- NewDistances], NewDistances, End)
    end.