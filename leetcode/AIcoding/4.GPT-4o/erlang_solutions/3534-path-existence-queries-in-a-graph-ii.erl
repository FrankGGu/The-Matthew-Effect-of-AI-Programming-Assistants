-module(solution).
-export([path_existence_queries/3]).

path_existence_queries(N, Edges, Queries) ->
    Graph = build_graph(N, Edges),
    lists:map(fun(Query) -> path_exists(Graph, Query) end, Queries).

build_graph(N, Edges) ->
    Graph = lists:foldl(fun({U, V}, Acc) ->
        maps:update(U, [V | maps:get(U, Acc, [])], Acc)
    end, maps:fold(fun(_, _, Acc) -> Acc end, maps:new(), Edges),
    lists:foldl(fun({V, U}, Acc) ->
        maps:update(V, [U | maps:get(V, Acc, [])], Acc)
    end, Graph, Edges).

path_exists(Graph, {A, B}) ->
    case maps:is_key(A, Graph) of
        false -> false;
        true ->
            visited = maps:new(),
            dfs(Graph, A, B, visited)
    end.

dfs(Graph, Current, Target, Visited) ->
    if
        Current =:= Target -> true;
        maps:is_key(Current, Visited) -> false;
        true ->
            NewVisited = maps:update(Current, true, Visited),
            case maps:get(Current, Graph, []) of
                [] -> false;
                Neighbors ->
                    lists:any(fun(Neighbor) -> dfs(Graph, Neighbor, Target, NewVisited) end, Neighbors)
            end
    end.