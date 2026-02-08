-module(solution).
-export([count_subtrees/2]).

count_subtrees(N, Edges) ->
    Graph = build_graph(N, Edges),
    lists:map(fun(X) -> count_subtree(Graph, X, N) end, lists:seq(1, N)).

build_graph(N, Edges) ->
    lists:foldl(fun({A, B}, Acc) ->
        MapA = maps:update_with(A, fun(L) -> [B | L] end, [B], Acc),
        MapB = maps:update_with(B, fun(L) -> [A | L] end, [A], MapA)
    end, maps:new(), Edges).

count_subtree(Graph, Node, N) ->
    Visited = maps:from_list([{Node, true}]),
    dfs(Graph, Node, Visited, 0).

dfs(Graph, Node, Visited, Depth) ->
    Children = maps:get(Node, Graph, []),
    lists:foldl(fun(Child, Acc) ->
        case maps:is_key(Child, Visited) of
            true -> Acc;
            false ->
                NewVisited = maps:update(Child, true, Visited),
                dfs(Graph, Child, NewVisited, Acc + 1)
        end
    end, Depth, Children).