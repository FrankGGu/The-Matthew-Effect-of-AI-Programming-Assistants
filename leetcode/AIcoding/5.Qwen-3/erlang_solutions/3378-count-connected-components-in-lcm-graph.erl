-module(solution).
-export([count_components/1]).

count_components(Edges) ->
    Graph = build_graph(Edges),
    Nodes = lists:usort(lists:flatten(Edges)),
    Visited = sets:new(),
    count_components(Graph, Nodes, Visited, 0).

build_graph(Edges) ->
    lists:foldl(fun({A, B}, Acc) ->
        Acc#{A => sets:add_element(B, maps:get(A, Acc, sets:new())),
             B => sets:add_element(A, maps:get(B, Acc, sets:new()))}
    end, #{}, Edges).

count_components(_, [], _, Count) ->
    Count;
count_components(Graph, [Node | Rest], Visited, Count) ->
    case sets:is_element(Node, Visited) of
        true ->
            count_components(Graph, Rest, Visited, Count);
        false ->
            NewVisited = dfs(Node, Graph, sets:add_element(Node, Visited)),
            count_components(Graph, Rest, NewVisited, Count + 1)
    end.

dfs(Node, Graph, Visited) ->
    Neighbors = maps:get(Node, Graph, sets:new()),
    lists:foldl(fun(Neighbor, V) ->
        case sets:is_element(Neighbor, V) of
            true -> V;
            false -> dfs(Neighbor, Graph, sets:add_element(Neighbor, V))
        end
    end, Visited, sets:to_list(Neighbors)).