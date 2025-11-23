-module(solution).
-export([possible_bipartition/2]).

possible_bipartition(N, Dislikes) ->
    Graph = build_graph(N, Dislikes),
    color_nodes(Graph, N, 1, []).

build_graph(N, Dislikes) ->
    Graph = lists:duplicate(N, []),
    lists:foldl(fun({A, B}, Acc) ->
        update_graph(Acc, A, B),
        update_graph(Acc, B, A)
    end, Graph, Dislikes).

update_graph(Graph, A, B) ->
    lists:update_element(A, lists:append(lists:element(A, Graph), [B]), Graph).

color_nodes(_, 0, _, _) ->
    true;
color_nodes(Graph, Node, Color, Colors) ->
    case lists:keyfind(Node, 1, Colors) of
        {Node, ExistingColor} ->
            ExistingColor =:= Color;
        false ->
            NewColors = [{Node, Color} | Colors],
            case lists:element(Node, Graph) of
                Neighbors ->
                    lists:all(fun(Neighbor) ->
                        color_nodes(Graph, Neighbor, -Color, NewColors)
                    end, Neighbors)
            end
    end,
    color_nodes(Graph, Node - 1, Color, Colors).