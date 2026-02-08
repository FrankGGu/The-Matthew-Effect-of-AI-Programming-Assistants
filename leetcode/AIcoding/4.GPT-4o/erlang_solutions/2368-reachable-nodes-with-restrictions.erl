-module(solution).
-export([reachable_nodes/3]).

reachable_nodes(Nodes, Edges, Restrictions) ->
    Graph = build_graph(Nodes, Edges),
    Restricted = maps:from_list(Restrictions),
    reachable(0, Graph, Restricted, sets:new(), 0).

build_graph(Nodes, Edges) ->
    Graph = lists:foldl(fun({U, V}, Acc) ->
        Acc1 = maps:update_with(U, fun(X) -> [V | X] end, [V], Acc),
        maps:update_with(V, fun(X) -> [U | X] end, [U], Acc1)
    end, maps:new(), Edges),
    Graph.

reachable(Node, Graph, Restrictions, Visited, Count) ->
    case maps:is_key(Node, Restrictions) of
        true -> Count;
        false ->
            Visited1 = sets:add(Node, Visited),
            Neighbors = maps:get(Node, Graph, []),
            lists:foldl(fun(Neighbor, Acc) ->
                if 
                    sets:is_element(Neighbor, Visited1) -> 
                        Acc;
                    true -> 
                        reachable(Neighbor, Graph, Restrictions, Visited1, Acc + 1)
                end
            end, Count + 1, Neighbors)
    end.