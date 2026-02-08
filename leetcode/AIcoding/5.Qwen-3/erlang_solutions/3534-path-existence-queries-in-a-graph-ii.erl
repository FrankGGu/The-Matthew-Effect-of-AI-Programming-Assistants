-module(path_existence_queries_in_a_graph_ii).
-export([query/2]).

query(Edges, Queries) ->
    Graph = build_graph(Edges),
    lists:map(fun(Q) -> path_exists(Graph, Q) end, Queries).

build_graph(Edges) ->
    maps:new() ++ [ {N, []} || N <- all_nodes(Edges) ] ++ 
    lists:foldl(fun({A,B}, Acc) -> 
        maps:update(A, [B | maps:get(A, Acc)], Acc)
    end, maps:new(), Edges).

all_nodes(Edges) ->
    lists:usort(lists:flatten([[A,B] || {A,B} <- Edges])).

path_exists(Graph, {Start, End}) ->
    dfs(Start, End, Graph, maps:new()).

dfs(Node, End, Graph, Visited) when Node == End ->
    true;
dfs(Node, End, Graph, Visited) ->
    case maps:get(Node, Visited, false) of
        true -> false;
        _ ->
            Visited1 = maps:put(Node, true, Visited),
            lists:any(fun(N) -> dfs(N, End, Graph, Visited1) end, maps:get(Node, Graph, []))
    end.