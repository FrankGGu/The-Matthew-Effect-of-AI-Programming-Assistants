-module(solution).
-export([count_components/2]).

count_components(N, edges) ->
    Graph = lists:foldl(fun({U, V}, Acc) ->
        maps:update_with(U, fun(L) -> [V | L] end, fun() -> [V] end, Acc)
        end, maps:from_list(lists:map(fun(X) -> {X, []} end, lists:seq(1, N))), edges),
    Visited = maps:fold(fun(_, _, VisitedAcc) -> VisitedAcc end, maps:empty(), Graph),
    lists:foldl(fun(X, Acc) -> 
        if 
            maps:find(X, Visited) == none -> 
                dfs(X, Graph, Visited) ++ Acc 
            ; 
            true -> Acc 
        end 
    end, [], lists:seq(1, N)).

dfs(Node, Graph, Visited) ->
    case maps:find(Node, Visited) of
        none ->
            NewVisited = maps:put(Node, true, Visited),
            Adj = maps:get(Node, Graph),
            lists:foldl(fun(X, Acc) -> dfs(X, Graph, Acc) end, NewVisited, Adj);
        _ -> 
            Visited
    end.