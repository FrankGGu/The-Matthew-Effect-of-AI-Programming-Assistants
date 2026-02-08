-module(unreachable_pairs).
-export([count_pairs/2]).

count_pairs(N, Edges) ->
    Graph = build_graph(N, Edges),
    Visited = sets:new(),
    Components = find_components(Graph, sets:new(), []),
    Total = 0,
    lists:foldl(fun(Size, Acc) ->
                        Acc + Size * (N - Size)
                end, 0, Components) div 2.

build_graph(N, Edges) ->
    lists:foldl(fun({U, V}, Acc) ->
                        Acc#{U => lists:append(maps:get(U, Acc, []), [V]),
                              V => lists:append(maps:get(V, Acc, []), [U])}
                end, maps:new(), Edges).

find_components(Graph, Visited, Acc) ->
    Nodes = maps:keys(Graph),
    Unvisited = lists:filter(fun(Node) ->
                                        not sets:is_element(Node, Visited)
                              end, Nodes),
    case Unvisited of
        [] ->
            Acc;
        [Start | _] ->
            {Component, NewVisited} = dfs(Graph, Start, sets:add_element(Start, Visited), sets:new()),
            find_components(Graph, NewVisited, [sets:size(Component) | Acc])
    end.

dfs(Graph, Node, Visited, Component) ->
    Neighbors = maps:get(Node, Graph, []),
    lists:foldl(fun(Neighbor, {AccVisited, AccComponent}) ->
                        if sets:is_element(Neighbor, AccVisited) then
                            {AccVisited, AccComponent}
                        else
                            {NewVisited, NewComponent} = dfs(Graph, Graph, Neighbor, sets:add_element(Neighbor, AccVisited), sets:add_element(Neighbor, AccComponent)),
                            {NewVisited, NewComponent}
                        end
                end, {Visited, sets:add_element(Node, Component)}, Neighbors).

dfs(Graph, Start, Visited, Component) ->
    dfs_helper(Graph, [Start], Visited, Component).

dfs_helper(Graph, [], Visited, Component) ->
    {Component, Visited};
dfs_helper(Graph, [Node | Rest], Visited, Component) ->
    Neighbors = maps:get(Node, Graph, []),
    UnvisitedNeighbors = lists:filter(fun(Neighbor) ->
                                                not sets:is_element(Neighbor, Visited)
                                      end, Neighbors),
    NewVisited = lists:foldl(fun(N, Acc) ->
                                      sets:add_element(N, Acc)
                              end, Visited, UnvisitedNeighbors),
    NewComponent = lists:foldl(fun(N, Acc) ->
                                        sets:add_element(N, Acc)
                                end, Component, UnvisitedNeighbors),
    dfs_helper(Graph, Rest ++ UnvisitedNeighbors, NewVisited, NewComponent).