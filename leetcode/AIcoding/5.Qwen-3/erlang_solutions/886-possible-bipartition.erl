-module(possible_bipartition).
-export([possible_bipartition/2]).

possible_bipartition(Values, Pairs) ->
    Graph = build_graph(Pairs),
    Colors = maps:new(),
    lists:all(fun(V) -> dfs(V, Graph, Colors, 0) end, Values).

build_graph(Pairs) ->
    build_graph(Pairs, maps:new()).

build_graph([], Graph) ->
    Graph;
build_graph([[A,B] | Rest], Graph) ->
    G1 = add_edge(A, B, Graph),
    G2 = add_edge(B, A, G1),
    build_graph(Rest, G2).

add_edge(Node, Neighbor, Graph) ->
    case maps:find(Node, Graph) of
        {ok, Neighbors} ->
            maps:put(Node, [Neighbor | Neighbors], Graph);
        error ->
            maps:put(Node, [Neighbor], Graph)
    end.

dfs(Node, Graph, Colors, Color) ->
    case maps:find(Node, Colors) of
        {ok, C} when C == Color ->
            true;
        {ok, C} ->
            false;
        error ->
            ok = maps:put(Node, Color, Colors),
            case maps:find(Node, Graph) of
                {ok, Neighbors} ->
                    lists:all(fun(N) -> dfs(N, Graph, Colors, 1 - Color) end, Neighbors);
                error ->
                    true
            end
    end.