-module(solution).
-export([min_time/2]).

min_time(Nodes, Edges) ->
    Graph = build_graph(Nodes, Edges),
    MinTime = dfs(Graph, Nodes, 0, 0),
    MinTime.

build_graph(Nodes, Edges) ->
    lists:foldl(fun({A, B}, Acc) ->
        maps:update_with(A, fun(L) -> [B | L] end, [B], Acc)
    end, maps:new(), Edges).

dfs(Graph, Nodes, Time, Visited) ->
    case lists:filter(fun(Node) -> maps:is_key(Node, Graph) end, Nodes) of
        [] -> Time;
        RemainingNodes ->
            lists:min(
                [dfs(Graph, RemainingNodes -- [Node], Time + 1 + length(maps:get(Node, Graph)), Visited + 1) || Node <- RemainingNodes]
            )
    end.