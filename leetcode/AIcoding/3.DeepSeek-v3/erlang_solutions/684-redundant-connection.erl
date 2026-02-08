findRedundantConnection(Edges) ->
    Parent = maps:new(),
    findRedundantConnection(Edges, Parent).

findRedundantConnection([Edge | Rest], Parent) ->
    [U, V] = Edge,
    case find(U, Parent) == find(V, Parent) of
        true -> Edge;
        false ->
            NewParent = union(U, V, Parent),
            findRedundantConnection(Rest, NewParent)
    end.

find(Node, Parent) ->
    case maps:get(Node, Parent, Node) of
        Node -> Node;
        P -> 
            Root = find(P, Parent),
            maps:put(Node, Root, Parent),
            Root
    end.

union(U, V, Parent) ->
    RootU = find(U, Parent),
    RootV = find(V, Parent),
    maps:put(RootU, RootV, Parent).