-module(solution).
-export([distance_limited_paths_exist/4]).

distance_limited_paths_exist(N, Edges, Queries, Result) ->
    Graph = build_graph(N, Edges),
    lists:map(fun({U, V, Limit}) -> 
        case dfs(Graph, U, V, Limit, []) of 
            true -> 1; 
            false -> 0 
        end 
    end, Queries).

build_graph(N, Edges) ->
    lists:foldl(fun({U, V}, Acc) -> 
        maps:update_with(U, fun(L) -> [V | L] end, [V], Acc) 
    end, maps:from_list(lists:map(fun(X) -> {X, []} end, lists:seq(1, N))), Edges).

dfs(Graph, U, V, Limit, Visited) ->
    case U =:= V of
        true -> true;
        false ->
            if 
                lists:member(U, Visited) -> false;
                true -> 
                    NewVisited = [U | Visited],
                    lists:any(fun(W) -> dfs(Graph, W, V, Limit, NewVisited) end, maps:get(U, Graph))
            end
    end.