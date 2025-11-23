-module(solution).
-export([palindrome_dfs/1]).

palindrome_dfs(Edges) ->
    Graph = build_graph(Edges),
    Start = hd(Edges),
    Visited = maps:empty(),
    dfs(Start, Graph, Visited, []).

dfs(Node, Graph, Visited, Path) ->
    case maps:get(Node, Visited, false) of
        true -> Path;
        false ->
            NewVisited = maps:put(Node, true, Visited),
            Neighbors = maps:get(Node, Graph, []),
            lists:foldl(fun(Neighbor, Acc) ->
                dfs(Neighbor, Graph, NewVisited, [Node | Acc])
            end, Path, Neighbors)
    end.

build_graph(Edges) ->
    lists:foldl(fun({A, B}, Acc) ->
        Acc1 = maps:update_with(A, fun(X) -> [B | X] end, [B], Acc),
        maps:update_with(B, fun(X) -> [A | X] end, [A], Acc1)
    end, maps:new(), Edges).