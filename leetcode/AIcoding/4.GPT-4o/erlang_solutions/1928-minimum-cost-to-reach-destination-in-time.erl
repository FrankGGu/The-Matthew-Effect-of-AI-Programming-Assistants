-module(solution).
-export([minCost/4]).

minCost(N, edges, time, maxCost) ->
    Graph = build_graph(edges),
    D = lists:duplicate(N, infinity),
    D1 = lists:duplicate(N, infinity),
    D1 = lists:update_element(1, 0, D1),
    {cost, _} = dijkstra(Graph, D1, time, maxCost, 1),
    if cost =< maxCost -> cost; true -> -1 end.

build_graph(Edges) ->
    lists:foldl(fun({A, B, C}, Acc) -> 
        maps:update_with(A, fun(_) -> C end, fun(X) -> min(X, C) end, Acc)
    end, maps:new(), Edges).

dijkstra(Graph, Dist, Time, MaxCost, Node) ->
    case lists:foldl(fun(Node, {Q, Dist}) -> 
        {Q1, Dist1} = lists:foldl(fun({Next, Cost}, {Q, Dist}) -> 
            NewDist = lists:nth(Node, Dist) + Cost,
            if NewDist =< MaxCost andalso NewDist < lists:nth(Next, Dist) -> 
                {lists:delete(Next, Q), lists:update_element(Next, NewDist, Dist)}; 
                true -> {Q, Dist} 
            end 
        end, {Q, Dist}, maps:get(Node, Graph)),
        {Q1, Dist1} 
    end, {[], Dist}, maps:keys(Graph)) of
        {[], Dist} -> hd(Dist);
        {Q, Dist} -> dijkstra(Graph, Dist, Time, MaxCost, hd(Q))
    end.