-module(solution).
-export([network_becomes_idle/2, network_becomes_idle/3]).

network_becomes_idle(Edges, Patience) ->
    network_becomes_idle(Edges, Patience, length(Patience)).

network_becomes_idle(Edges, Patience, N) ->
    Adj = build_adjacency_list(Edges, N),
    Dist = dijkstra(Adj, N),
    MaxTime = lists:foldl(
        fun(I, Acc) ->
            D = lists:nth(I, Dist),
            if
                D == 0 -> Acc;
                true ->
                    P = lists:nth(I, Patience),
                    Time = case (2 * D) rem P of
                        0 -> 2 * D + ((2 * D) div P - 1) * P;
                        Rem -> 2 * D + (2 * D div P) * P
                    end,
                    max(Time, Acc)
            end
        end,
        0,
        lists:seq(1, N)
    ),
    MaxTime + 1.

build_adjacency_list(Edges, N) ->
    Adj = lists:duplicate(N + 1, []),
    lists:foldl(
        fun([U, V], Acc) ->
            U1 = U + 1,
            V1 = V + 1,
            Acc1 = set_adj(U1, V1, Acc),
            set_adj(V1, U1, Acc1)
        end,
        Adj,
        Edges
    ).

set_adj(U, V, Adj) ->
    Existing = lists:nth(U, Adj),
    lists:sublist(Adj, U - 1) ++ [[V | Existing]] ++ lists:nthtail(U, Adj).

dijkstra(Adj, N) ->
    Dist = lists:duplicate(N + 1, infinity),
    Dist1 = setelement(1, Dist, 0),
    Q = [{0, 1}],
    dijkstra_loop(Adj, Dist1, Q).

dijkstra_loop(Adj, Dist, []) -> Dist;
dijkstra_loop(Adj, Dist, [{D, U} | RestQ]) ->
    case D > lists:nth(U, Dist) of
        true -> dijkstra_loop(Adj, Dist, RestQ);
        false ->
            Neighbors = lists:nth(U, Adj),
            {NewDist, NewQ} = lists:foldl(
                fun(V, {CurrentDist, CurrentQ}) ->
                    NewD = D + 1,
                    case NewD < lists:nth(V, CurrentDist) of
                        true ->
                            NewDist1 = setelement(V, CurrentDist, NewD),
                            {NewDist1, [{NewD, V} | CurrentQ]};
                        false -> {CurrentDist, CurrentQ}
                    end
                end,
                {Dist, RestQ},
                Neighbors
            ),
            dijkstra_loop(Adj, NewDist, NewQ)
    end.