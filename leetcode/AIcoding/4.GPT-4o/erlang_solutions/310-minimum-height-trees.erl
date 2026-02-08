-spec find_min_height_trees(N :: integer(), Edges :: [[integer()]]) -> [integer()].

find_min_height_trees(N, Edges) ->
    Graph = build_graph(N, Edges),
    Leaves = lists:filter(fun({_, Next}) -> Next == [] end, Graph),
    prune_leaves(Leaves, Graph).

build_graph(N, Edges) ->
    lists:foldl(fun([A, B], Acc) ->
        update_graph(A, B, Acc),
        update_graph(B, A, Acc)
    end, lists:seq(0, N-1), Edges).

update_graph(A, B, Graph) ->
    lists:keyreplace(A, 1, Graph, {A, [B | lists:keyfind(A, 1, Graph, {A, []}) | []]}).

prune_leaves([], Graph) -> Graph;
prune_leaves([Leaf | Rest], Graph) ->
    UpdatedGraph = lists:map(fun({Node, Neighbors}) ->
                                  if Node == Leaf -> {Node, tl(Neighbors)};
                                     true -> {Node, Neighbors}
                                  end
                              end, Graph),
    prune_leaves(Rest, UpdatedGraph).
