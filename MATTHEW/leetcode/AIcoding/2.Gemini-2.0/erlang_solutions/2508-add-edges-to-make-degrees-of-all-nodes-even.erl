-module(solution).
-export([make_connected/2]).

make_connected(N, Edges) ->
    NumEdges = length(Edges),
    if
        NumEdges < N - 1 ->
            -1;
        true ->
            Graph = build_graph(N, Edges),
            Components = find_connected_components(Graph, N),
            length(Components) - 1
    end.

build_graph(N, Edges) ->
    lists:foldl(
        fun([U, V], Acc) ->
            Acc#{U => lists:append(maps:get(U, Acc, []), [V]),
                  V => lists:append(maps:get(V, Acc, []), [U])}
        end,
        maps:from_list([{I, []} || I <- lists:seq(1, N)]),
        Edges
    ).

find_connected_components(Graph, N) ->
    Visited = sets:new(),
    lists:foldl(
        fun(Node, {Acc, Vis}) ->
            if
                sets:is_element(Node, Vis) ->
                    {Acc, Vis};
                true ->
                    Component = bfs([Node], Graph, Vis, sets:new()),
                    {lists:append(Acc, [sets:to_list(Component)]), sets:union(Vis, Component)}
            end
        end,
        {[], sets:new()},
        lists:seq(1, N)
    ).

bfs([Node | Rest], Graph, Vis, Component) ->
    if
        sets:is_element(Node, Vis) ->
            bfs(Rest, Graph, Vis, Component);
        true ->
            Neighbors = maps:get(Node, Graph, []),
            NewComponent = sets:add_element(Node, Component),
            NewVis = sets:add_element(Node, Vis),
            bfs(lists:append(Rest, Neighbors), Graph, NewVis, NewComponent)
    end;
bfs([], _Graph, _Vis, Component) ->
    Component.