-module(reconstruct_tree).
-export([number_of_ways/1]).

number_of_ways(Pairs) ->
    graph_from_pairs(Pairs).

graph_from_pairs(Pairs) ->
    Degrees = lists:foldl(
        fun([U, V], Acc) ->
            Acc#{U => maps:get(U, Acc, 0) + 1,
                  V => maps:get(V, Acc, 0) + 1}
        end,
        #{},
        Pairs
    ),

    Possible_Root = lists:keyfind(lists:max(maps:values(Degrees)), 2, lists:zip(maps:keys(Degrees), maps:values(Degrees))),

    case Possible_Root of
        false -> 0;
        {Root, _} ->
            case valid_tree(Root, Pairs, Degrees) of
                true ->
                    case count_valid_orders(Root, Pairs, Degrees) of
                        0 -> 0;
                        N when N > 0 -> N
                    end;
                false -> 0
            end
    end.

valid_tree(Root, Pairs, Degrees) ->
    Adj = make_adjacency_list(Pairs),

    Visited = sets:new(),

    valid_tree_helper(Root, undefined, Adj, sets:add_element(Root, Visited), Degrees).

valid_tree_helper(Node, Parent, Adj, Visited, Degrees) ->
    Neighbors = maps:get(Node, Adj, []),

    lists:all(
        fun(Neighbor) ->
            case sets:is_element(Neighbor, Visited) of
                true ->
                    Neighbor == Parent;
                false ->
                    valid_tree_helper(Neighbor, Node, Adj, sets:add_element(Neighbor, Visited), Degrees)
            end
        end,
        Neighbors
    ) andalso sets:size(Visited) == maps:size(Degrees).

make_adjacency_list(Pairs) ->
    lists:foldl(
        fun([U, V], Acc) ->
            Acc#{U => lists:usort(Acc[U, []] ++ [V]),
                  V => lists:usort(Acc[V, []] ++ [U])}
        end,
        #{},
        Pairs
    ).

count_valid_orders(Root, Pairs, Degrees) ->
    Adj = make_adjacency_list(Pairs),
    count_valid_orders_helper(Root, undefined, Adj, Degrees, 0).

count_valid_orders_helper(Node, Parent, Adj, Degrees, Count) ->
    Neighbors = maps:get(Node, Adj, []),
    Children = lists:filter(fun(N) -> N /= Parent end, Neighbors),

    case Children of
        [] -> 1;
        _ ->
            Product = lists:foldl(
                fun(Child, Acc) ->
                    Acc * count_valid_orders_helper(Child, Node, Adj, Degrees, 0)
                end,
                1,
                Children
            ),

            case is_forced_edge(Node, Children, Adj, Degrees) of
                true -> Product;
                false -> 2 * Product
            end
    end.

is_forced_edge(Node, Children, Adj, Degrees) ->
    lists:all(
        fun(Child) ->
            Degree_Node = maps:get(Node, Degrees, 0),
            Degree_Child = maps:get(Child, Degrees, 0),

            Degree_Child > Degree_Node
        end,
        Children
    ).