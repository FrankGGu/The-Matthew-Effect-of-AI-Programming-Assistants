-module(airport_code).
-export([find_largest_component/1]).

find_largest_component(Edges) ->
    Graph = build_graph(Edges),
    Visited = sets:new(),
    MaxSize = 0,
    lists:foldl(fun(Node, Acc) ->
        case sets:is_element(Node, Visited) of
            true -> Acc;
            false ->
                {Size, NewVisited} = dfs(Node, Graph, Visited, 0),
                sets:union(Visited, NewVisited),
                if Size > Acc -> Size; true -> Acc end
        end
    end, MaxSize, get_all_nodes(Graph)).

build_graph(Edges) ->
    lists:foldl(fun({A,B}, Acc) ->
        Acc1 = case maps:is_key(A, Acc) of
            true -> Acc;
            false -> maps:put(A, [], Acc)
        end,
        Acc2 = case maps:is_key(B, Acc1) of
            true -> Acc1;
            false -> maps:put(B, [], Acc1)
        end,
        maps:put(A, [B | maps:get(A, Acc2)], Acc2),
        maps:put(B, [A | maps:get(B, Acc2)], Acc2)
    end, maps:new(), Edges).

get_all_nodes(Graph) ->
    maps:keys(Graph).

dfs(Node, Graph, Visited, Count) ->
    case sets:is_element(Node, Visited) of
        true -> {Count, Visited};
        false ->
            NewVisited = sets:add_element(Node, Visited),
            Neighbors = maps:get(Node, Graph),
            lists:foldl(fun(Neighbor, {C, V}) ->
                {NC, NV} = dfs(Neighbor, Graph, V, C),
                {NC + 1, NV}
            end, {Count + 1, NewVisited}, Neighbors)
    end.