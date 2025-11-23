-module(solution).
-export([closest_nodes/3]).

-record(node, {val, left = null, right = null}).

closest_nodes(BST, Queries) ->
    Tree = build_tree(BST),
    [find_closest_nodes(Tree, Q) || Q <- Queries].

build_tree([]) ->
    null;
build_tree([{Val, L, R} | T]) ->
    Node = #node{val = Val, left = build_tree(L), right = build_tree(R)},
    build_tree(T), Node.

find_closest_nodes(Tree, Q) ->
    case find_closest(Tree, Q) of
        {none, none} -> [-1, -1];
        {left, right} -> [left, right]
    end.

find_closest(null, _) -> {none, none};
find_closest(Tree = #node{val = Val, left = L, right = R}, Q) ->
    case Q < Val of
        true -> 
            {LClosest, RClosest} = find_closest(L, Q),
            if
                LClosest =/= none -> {LClosest, Val};
                true -> {none, Val}
            end;
        false -> 
            {LClosest, RClosest} = find_closest(R, Q),
            if
                RClosest =/= none -> {Val, RClosest};
                true -> {Val, none}
            end
    end.