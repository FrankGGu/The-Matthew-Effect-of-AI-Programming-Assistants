-module(solution).
-export([find_min_time/2]).

find_min_time(Rooms, Start) ->
    N = length(Rooms),
    Graph = build_graph(Rooms),
    D = lists:duplicate(N, infinity),
    D1 = lists:update_element(Start + 1, D, 0),
    bfs(Graph, D1, Start).

build_graph(Rooms) ->
    lists:map(fun({_, Edges}) -> Edges end, Rooms).

bfs(Graph, Dist, Start) ->
    bfs_helper([{Start, 0}], Dist).

bfs_helper([], Dist) ->
    Dist;
bfs_helper([{Node, Time} | Rest], Dist) ->
    NewDist = lists:update_element(Node + 1, Dist, Time),
    NextNodes = lists:map(fun(X) -> {X, Time + 1} end, lists:nth(Node + 1, Graph)),
    bfs_helper(Rest ++ NextNodes, NewDist).