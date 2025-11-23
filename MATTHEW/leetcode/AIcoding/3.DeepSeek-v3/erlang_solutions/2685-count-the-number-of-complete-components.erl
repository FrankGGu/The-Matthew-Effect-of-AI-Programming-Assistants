-spec count_complete_components(N :: integer(), Edges :: [[integer()]]) -> integer().
count_complete_components(N, Edges) ->
    Parent = lists:seq(0, N - 1),
    Size = lists:duplicate(N, 1),
    {Parent1, Size1} = build_union_find(Edges, Parent, Size),
    Components = get_components(N, Parent1),
    ComponentNodes = maps:to_list(Components),
    count_complete(ComponentNodes, Size1, Edges).

build_union_find([], Parent, Size) -> {Parent, Size};
build_union_find([[U, V] | Rest], Parent, Size) ->
    RootU = find(U, Parent),
    RootV = find(V, Parent),
    if
        RootU =/= RootV ->
            NewParent = update_parent(Parent, RootU, RootV),
            NewSize = update_size(Size, RootU, RootV),
            build_union_find(Rest, NewParent, NewSize);
        true ->
            build_union_find(Rest, Parent, Size)
    end.

find(Node, Parent) ->
    case lists:nth(Node + 1, Parent) of
        Node -> Node;
        P -> find(P, Parent)
    end.

update_parent(Parent, RootU, RootV) ->
    lists:sublist(Parent, RootU + 1, 1, [RootV]) ++
    lists:nthtail(RootU + 1, Parent).

update_size(Size, RootU, RootV) ->
    SizeU = lists:nth(RootU + 1, Size),
    SizeV = lists:nth(RootV + 1, Size),
    lists:sublist(Size, RootV + 1, 1, [SizeU + SizeV]) ++
    lists:nthtail(RootV + 1, Size).

get_components(N, Parent) ->
    lists:foldl(fun(Node, Acc) ->
        Root = find(Node, Parent),
        maps:update_with(Root, fun(Nodes) -> [Node | Nodes] end, [Node], Acc)
    end, maps:new(), lists:seq(0, N - 1)).

count_complete([], _, _) -> 0;
count_complete([{Root, Nodes} | Rest], Size, Edges) ->
    K = length(Nodes),
    ExpectedEdges = K * (K - 1) div 2,
    ActualEdges = count_edges(Nodes, Edges),
    if
        ActualEdges == ExpectedEdges -> 1 + count_complete(Rest, Size, Edges);
        true -> count_complete(Rest, Size, Edges)
    end.

count_edges(Nodes, Edges) ->
    NodeSet = sets:from_list(Nodes),
    lists:foldl(fun([U, V], Acc) ->
        case sets:is_element(U, NodeSet) andalso sets:is_element(V, NodeSet) of
            true -> Acc + 1;
            false -> Acc
        end
    end, 0, Edges).