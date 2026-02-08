-module(solution).
-export([shortestAlternatingPaths/3]).

shortestAlternatingPaths(N, RedEdges, BlueEdges) ->
    Graph = build_graph(N, RedEdges, BlueEdges),
    bfs(Graph, N).

build_graph(N, RedEdges, BlueEdges) ->
    RedGraph = lists:foldl(fun({X, Y}, Acc) -> maps:update(X, [{Y, red}], Acc); end, maps:from_list(lists:map(fun(X) -> {X, []} end, lists:seq(0, N - 1))), RedEdges),
    BlueGraph = lists:foldl(fun({X, Y}, Acc) -> maps:update(X, [{Y, blue}], Acc); end, RedGraph, BlueEdges),
    BlueGraph.

bfs(Graph, N) ->
    Queue = [{0, 0, red}, {0, 0, blue}],
    Visited = maps:from_list([{0, {red, 0}}, {0, {blue, 0}}]),
    bfs_helper(Queue, Visited, Graph, N).

bfs_helper([], Visited, _, N) ->
    lists:map(fun(I) -> case maps:is_key(I, Visited) of
                           true -> maps:get(I, Visited);
                           false -> -1
                         end
                end, lists:seq(0, N - 1));
bfs_helper([{Dist, Node, Color} | Rest], Visited, Graph, N) ->
    NewColor = case Color of
                    red -> blue;
                    blue -> red
                end,
    edges = maps:get(Node, Graph),
    NewVisited = lists:foldl(fun({NextNode, _Color}, Acc) ->
                                  case maps:is_key(NextNode, Acc) of
                                      true -> Acc;
                                      false -> maps:update(NextNode, {NewColor, Dist + 1}, Acc)
                                  end
                              end, Visited, edges),
    bfs_helper(Rest ++ lists:map(fun({NextNode, Color}) -> {Dist + 1, NextNode, Color} end, edges), NewVisited, Graph, N).