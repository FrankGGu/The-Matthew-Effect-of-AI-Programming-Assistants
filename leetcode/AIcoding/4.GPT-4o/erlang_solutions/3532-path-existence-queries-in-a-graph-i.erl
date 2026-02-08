-module(solution).
-export([path_existence_queries/3]).

path_existence_queries(N, edges, queries) ->
    Graph = build_graph(N, edges),
    lists:map(fun({U, V}) -> if
        path_exists(U, V, Graph, []) ->
            true;
        true -> false
    end end, queries).

build_graph(N, Edges) ->
    Graph = lists:foldl(fun({U, V}, Acc) ->
        maps:update_with(U, fun(L) -> [V | L] end, fun() -> [V] end, Acc)
    end, maps:from_list(lists:map(fun(X) -> {X, []} end, lists:seq(1, N))), Edges),
    Graph.

path_exists(U, V, Graph, Visited) ->
    case U == V of
        true -> true;
        false ->
            case maps:get(U, Graph, []) of
                [] -> false;
                Neighbors ->
                    lists:any(fun(N) ->
                        not lists:member(N, Visited) andalso
                        path_exists(N, V, Graph, [U | Visited])
                    end, Neighbors)
            end
    end.