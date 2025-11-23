-module(solution).
-export([count_paths/3]).

count_paths(N, roads, L) ->
    Graph = create_graph(roads),
    Mod = 1000000007,
    dfs(Graph, 0, N - 1, L, Mod, 0).

create_graph(Roads) ->
    Graph = lists:foldl(fun({X, Y, _}, Acc) -> 
        update_graph(Acc, X, Y), 
        update_graph(Acc, Y, X) 
    end, dict:new(), Roads),
    Graph.

update_graph(Graph, X, Y) ->
    case dict:find(X, Graph) of
        {ok, Edges} -> dict:store(X, [{Y, 1} | Edges], Graph);
        _ -> dict:store(X, [{Y, 1}], Graph)
    end.

dfs(Graph, Current, Destination, L, Mod, Steps) when Current =:= Destination, Steps =< L -> 
    if Steps =:= L -> 1; true -> 0 end;
dfs(Graph, Current, Destination, L, Mod, Steps) when Steps >= L -> 0;
dfs(Graph, Current, Destination, L, Mod, Steps) -> 
    case dict:find(Current, Graph) of
        {ok, Edges} -> 
            lists:foldl(fun({Next, _}, Acc) -> 
                (Acc + dfs(Graph, Next, Destination, L, Mod, Steps + 1)) rem Mod 
            end, 0, Edges);
        _ -> 0
    end.