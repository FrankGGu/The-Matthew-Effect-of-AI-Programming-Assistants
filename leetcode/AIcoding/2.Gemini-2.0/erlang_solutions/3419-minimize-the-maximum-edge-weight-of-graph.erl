-module(minimize_max_edge).
-export([minimize_max_edge_weight/3]).

minimize_max_edge_weight(N, Edges, MaxOperations) ->
    edges_sorted = lists:sort(fun({_, _, W1}, {_, _, W2}) -> W1 < W2 end, Edges),
    {ok, Result} = binary_search(1, get_max_weight(edges_sorted), N, Edges, MaxOperations, edges_sorted),
    Result.

get_max_weight(Edges) ->
    lists:foldl(fun({_, _, W}, Acc) -> max(W, Acc) end, 0, Edges).

binary_search(Low, High, N, Edges, MaxOperations, EdgesSorted) when Low > High ->
    {error, -1};
binary_search(Low, High, N, Edges, MaxOperations, EdgesSorted) ->
    Mid = (Low + High) div 2,
    case possible(N, Edges, MaxOperations, Mid) of
        true ->
            case binary_search(Low, Mid - 1, N, Edges, MaxOperations, EdgesSorted) of
                {ok, Res} -> {ok, Res};
                {error, _} -> {ok, Mid}
            end;
        false ->
            binary_search(Mid + 1, High, N, Edges, MaxOperations, EdgesSorted)
    end.

possible(N, Edges, MaxOperations, MaxWeight) ->
    Graph = create_graph(N, Edges, MaxWeight),
    CC = count_connected_components(N, Graph),
    CC - 1 =< MaxOperations.

create_graph(N, Edges, MaxWeight) ->
    lists:foldl(fun({U, V, W}, Acc) ->
                        if W =< MaxWeight ->
                            Acc#{U => lists:sort([V | maps:get(U, Acc, [])]),
                                V => lists:sort([U | maps:get(V, Acc, [])])}
                        else
                            Acc
                        end
                end, #{}, Edges).

count_connected_components(N, Graph) ->
    Visited = gb_sets:empty(),
    count_cc(1, N, Graph, Visited, 0).

count_cc(Node, N, Graph, Visited, Count) when Node > N ->
    Count;
count_cc(Node, N, Graph, Visited, Count) ->
    case gb_sets:is_element(Node, Visited) of
        true ->
            count_cc(Node + 1, N, Graph, Visited, Count);
        false ->
            NewVisited = dfs(Node, Graph, gb_sets:add(Node, Visited)),
            count_cc(Node + 1, N, Graph, NewVisited, Count + 1)
    end.

dfs(Node, Graph, Visited) ->
    Neighbors = maps:get(Node, Graph, []),
    lists:foldl(fun(Neighbor, Acc) ->
                        case gb_sets:is_element(Neighbor, Acc) of
                            true ->
                                Acc;
                            false ->
                                dfs(Neighbor, Graph, gb_sets:add(Neighbor, Acc))
                        end
                end, Visited, Neighbors).