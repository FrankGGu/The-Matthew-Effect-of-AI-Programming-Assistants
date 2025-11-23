-module(solution).
-export([is_bipartite/1]).

is_bipartite(Graph) ->
    Colors = dict:new(),
    lists:all(fun(Node) -> is_bipartite_helper(Node, Graph, Colors, 0) end, lists:seq(0, length(Graph) - 1)).

is_bipartite_helper(Node, Graph, Colors, Color) ->
    case dict:find(Node, Colors) of
        {ok, C} ->
            C == Color;
        error ->
            dict:store(Node, Color, Colors),
            Neighbors = lists:nth(Node + 1, Graph),
            lists:all(fun(Neighbor) -> is_bipartite_helper(Neighbor, Graph, Colors, 1 - Color) end, Neighbors)
    end.