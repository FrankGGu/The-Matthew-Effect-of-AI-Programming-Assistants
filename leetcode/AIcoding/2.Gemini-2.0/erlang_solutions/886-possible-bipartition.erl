-module(possible_bipartition).
-export([possible_bipartition/2]).

possible_bipartition(N, Dislikes) ->
    graph_from_dislikes(Dislikes, Graph),
    coloring(N, Graph).

graph_from_dislikes(Dislikes, Graph) ->
    lists:foldl(fun({A, B}, Acc) ->
                        Acc#{A => lists:append(maps:get(A, Acc, []), [B]),
                              B => lists:append(maps:get(B, Acc, []), [A])}
                end, #{}, Dislikes).

coloring(N, Graph) ->
    coloring(lists:seq(1, N), Graph, #{}, []).

coloring([], _, _, _) ->
    true;
coloring([Node | Rest], Graph, Colors, Visited) ->
    case maps:is_key(Node, Colors) of
        true ->
            coloring(Rest, Graph, Colors, Visited);
        false ->
            try_color(Node, 1, Graph, Colors, Visited) orelse
            try_color(Node, 2, Graph, Colors, Visited)
    end.

try_color(Node, Color, Graph, Colors, Visited) ->
    NewColors = Colors#{Node => Color},
    Neighbors = maps:get(Node, Graph, []),
    case check_neighbors(Neighbors, Color, NewColors) of
        true ->
            coloring(lists:delete(Node, lists:seq(1, maps:len(Graph))), Graph, NewColors, Visited);
        false ->
            false
    end.

check_neighbors([], _, _) ->
    true;
check_neighbors([Neighbor | Rest], Color, Colors) ->
    case maps:is_key(Neighbor, Colors) of
        true ->
            case maps:get(Neighbor, Colors) == Color of
                true ->
                    false;
                false ->
                    check_neighbors(Rest, Color, Colors)
            end;
        false ->
            check_neighbors(Rest, Color, Colors)
    end.