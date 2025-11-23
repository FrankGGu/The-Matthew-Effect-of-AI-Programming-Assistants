-module(solution).
-export([min_total_price/2]).

min_total_price(Edges, Queries) ->
    N = length(Edges) + 1,
    Graph = build_graph(Edges),
    {_, _, _} = build_tree(Graph, 0, -1, 0),
    [process_query(Query, Graph) || Query <- Queries].

build_graph(Edges) ->
    lists:foldl(fun({U, V}, Acc) ->
        Acc#{U => [V | maps:get(U, Acc, [])], V => [U | maps:get(V, Acc, [])]}
    end, #{}, Edges).

build_tree(_, _, _, _) -> ok.

process_query(_Query, _Graph) -> 0.