-module(solution).
-export([garden_no_adj/1]).

garden_no_adj(N) ->
    Graph = lists:seq(1, N),
    Colors = lists:map(fun(_) -> 0 end, Graph),
    lists:foldl(fun(X, Acc) -> assign_color(X, Acc, Graph) end, Colors, Graph).

assign_color(Node, Colors, Graph) ->
    NeighborColors = get_neighbor_colors(Node, Colors, Graph),
    Color = find_color(NeighborColors),
    lists:replace(Node, Color, Colors).

get_neighbor_colors(Node, Colors, Graph) ->
    % Placeholder for neighbor finding logic
    NeighborIndices = get_neighbors(Node, Graph),
    lists:map(fun(Index) -> lists:nth(Index, Colors) end, NeighborIndices).

get_neighbors(Node, Graph) ->
    % Placeholder for neighbor finding logic
    [].

find_color(NeighborColors) ->
    ColorList = [1, 2, 3],
    lists:subtract(ColorList, NeighborColors).

lists:replace(Index, Value, List) ->
    lists:map(fun({Idx, Val}) -> if Idx =:= Index -> Value; true -> Val end end, lists:zip(lists:seq(1, length(List)), List)).