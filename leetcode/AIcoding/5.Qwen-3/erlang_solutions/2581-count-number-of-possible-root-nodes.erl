-module(solution).
-export([possible_roots/1]).

possible_roots(Relations) ->
    Graph = build_graph(Relations),
    Nodes = lists:usort(lists:flatten(Relations)),
    lists:foldl(fun(Node, Acc) -> 
        case can_reach_all(Graph, Node, sets:new()) of
            true -> [Node | Acc];
            false -> Acc
        end
    end, [], Nodes).

build_graph(Relations) ->
    lists:foldl(fun({A, B}, Acc) ->
        Acc#{A => maps:get(A, Acc, []), B => maps:get(B, Acc, [])}
    end, #{}, Relations).

can_reach_all(Graph, Node, Visited) ->
    case sets:is_element(Node, Visited) of
        true -> true;
        false ->
            NewVisited = sets:add_element(Node, Visited),
            Children = maps:get(Node, Graph, []),
            lists:all(fun(Child) -> can_reach_all(Graph, Child, NewVisited) end, Children)
    end.