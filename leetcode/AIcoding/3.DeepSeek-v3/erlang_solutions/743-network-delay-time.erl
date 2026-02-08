-module(solution).
-export([network_delay_time/3]).

network_delay_time(Times, N, K) ->
    Graph = build_graph(Times, N),
    Dist = dijkstra(Graph, K, N),
    Max = lists:max(Dist),
    if Max == infinity -> -1; true -> Max end.

build_graph(Times, N) ->
    Graph = lists:duplicate(N + 1, []),
    lists:foldl(fun([U, V, W], Acc) ->
                        update_graph(Acc, U, V, W)
                end, Graph, Times).

update_graph(Graph, U, V, W) ->
    Neighbors = lists:keyfind(U, 1, Graph),
    case Neighbors of
        false -> Graph;
        {U, List} ->
            NewList = [{V, W} | List],
            lists:keyreplace(U, 1, Graph, {U, NewList})
    end.

dijkstra(Graph, Start, N) ->
    Dist = array:from_list([0 || _ <- lists:seq(0, N)]),
    Dist1 = array:set(Start, 0, Dist),
    Q = [{0, Start}],
    dijkstra_loop(Graph, Q, Dist1).

dijkstra_loop(Graph, Q, Dist) ->
    case Q of
        [] -> array:to_list(Dist);
        [{D, U} | RestQ] ->
            case array:get(U, Dist) < D of
                true -> dijkstra_loop(Graph, RestQ, Dist);
                false ->
                    Neighbors = lists:keyfind(U, 1, Graph),
                    case Neighbors of
                        false -> dijkstra_loop(Graph, RestQ, Dist);
                        {U, List} ->
                            {NewQ, NewDist} = 
                                lists:foldl(fun({V, W}, {AccQ, AccDist}) ->
                                                   Alt = D + W,
                                                   case Alt < array:get(V, AccDist) of
                                                       true ->
                                                           NewAccDist = array:set(V, Alt, AccDist),
                                                           NewAccQ = [{Alt, V} | AccQ],
                                                           {NewAccQ, NewAccDist};
                                                       false -> {AccQ, AccDist}
                                                   end
                                           end, {RestQ, Dist}, List),
                            dijkstra_loop(Graph, NewQ, NewDist)
                    end
            end
    end.