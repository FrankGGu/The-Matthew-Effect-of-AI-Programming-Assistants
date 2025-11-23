-module(cheapest_flights).
-export([find_cheapest_price/3]).

find_cheapest_price(N, Flights, Src, Dst, K) ->
    graph_to_adjacency_list(Flights, AdjList),
    dijkstra(N, AdjList, Src, Dst, K).

graph_to_adjacency_list(Flights, AdjList) ->
    lists:foldl(fun({U, V, W}, Acc) ->
        case maps:is_key(U, Acc) of
            true ->
                maps:update(U, [{V, W} | maps:get(U, Acc)], Acc);
            false ->
                maps:put(U, [{V, W}], Acc)
        end
    end, #{}, Flights).

dijkstra(N, AdjList, Src, Dst, K) ->
    Q = orddict:new(),
    orddict:store({Src, -1}, 0, Q, Q1),
    Dist = array:new(N, {default, infinity}),
    array:set({Src, -1}, 0, Dist, Dist1),
    dijkstra_helper(AdjList, Q1, Dist1, Dst, K).

dijkstra_helper(_, Q, Dist, Dst, _) when orddict:is_empty(Q) ->
    case array:get({Dst, 0}, Dist) of
        infinity -> -1;
        Cost -> Cost
    end;
dijkstra_helper(AdjList, Q, Dist, Dst, K) ->
    {{{Node, Stps}, Cost}, Q1} = orddict:fetch_delete_min(Q),
    case maps:is_key(Node, AdjList) of
        false ->
            dijkstra_helper(AdjList, Q1, Dist, Dst, K);
        true ->
            Neighbors = maps:get(Node, AdjList),
            lists:foldl(fun({Neighbor, Weight}, AccQ) ->
                NewStps = Stps + 1,
                case NewStps > K of
                    true ->
                        AccQ;
                    false ->
                        NewCost = Cost + Weight,
                        case array:get({Neighbor, NewStps}, Dist) of
                            infinity ->
                                Dist1 = array:set({Neighbor, NewStps}, NewCost, Dist),
                                orddict:store({Neighbor, NewStps}, NewCost, AccQ, AccQ1),
                                Dist1;
                            OldCost when NewCost < OldCost ->
                                Dist1 = array:set({Neighbor, NewStps}, NewCost, Dist),
                                orddict:store({Neighbor, NewStps}, NewCost, AccQ, AccQ1),
                                Dist1;
                            _ ->
                                AccQ
                        end
                end
            end, Q1, Neighbors, Q2),
            dijkstra_helper(AdjList, Q2, Dist, Dst, K)
    end.

-define(infinity, 16#7fffffff).