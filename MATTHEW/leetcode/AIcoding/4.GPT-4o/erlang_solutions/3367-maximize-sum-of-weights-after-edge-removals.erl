-module(solution).
-export([maxWeightSum/2]).

maxWeightSum(N, Edges) ->
    Graph = build_graph(N, Edges),
    MaxSum = dfs(Graph, 1, [], 0),
    MaxSum.

build_graph(N, Edges) ->
    Lists = lists:foldl(fun({U, V, W}, Acc) -> 
        maps:update_with(U, fun(X) -> X ++ [{V, W}] end, [{V, W}], Acc)
    end, maps:new(), Edges),
    lists:foldl(fun(V, Acc) -> 
        maps:update_with(V, fun(X) -> X ++ [] end, [], Acc)
    end, Lists, lists:seq(1, N)).

dfs(Graph, Node, Visited, Acc) ->
    if 
        lists:member(Node, Visited) -> Acc;
        true -> 
            NewVisited = [Node | Visited],
            Neighbors = maps:get(Node, Graph, []),
            lists:foldl(fun({Neighbor, Weight}, Acc1) -> 
                dfs(Graph, Neighbor, NewVisited, Acc1 + Weight)
            end, Acc, Neighbors)
    end.