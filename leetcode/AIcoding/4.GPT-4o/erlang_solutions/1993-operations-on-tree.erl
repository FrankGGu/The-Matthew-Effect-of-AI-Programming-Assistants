-module(solution).
-export([OperationsOnTree/2]).

-record(node, {val, left = null, right = null}).

OperationsOnTree(Root, Operations) ->
    Tree = build_tree(Root),
    lists:map(fun({Op, X}) -> apply_operation(Tree, Op, X) end, Operations).

build_tree([]) -> null;
build_tree([{Val, L, R} | T]) -> 
    Node = #node{val = Val, left = build_tree(L), right = build_tree(R)},
    Node.

apply_operation(Tree, {insert, X}) -> 
    insert(Tree, X);
apply_operation(Tree, {delete, X}) -> 
    delete(Tree, X);
apply_operation(Tree, {search, X}) -> 
    search(Tree, X).

insert(null, X) -> #node{val = X};
insert(#node{val = Val, left = L, right = R} = Node, X) when X < Val -> 
    Node#node{left = insert(L, X)};
insert(#node{val = Val, left = L, right = R} = Node, X) when X > Val -> 
    Node#node{right = insert(R, X)};
insert(Node, _) -> Node.

delete(null, _) -> null;
delete(#node{val = Val, left = L, right = R}, X) when X < Val -> 
    #node{val = Val, left = delete(L, X), right = R};
delete(#node{val = Val, left = L, right = R}, X) when X > Val -> 
    #node{val = Val, left = L, right = delete(R, X)};
delete(#node{val = Val, left = L, right = R}, Val) -> 
    case {L, R} of 
        {null, null} -> null;
        {null, _} -> R;
        {_, null} -> L;
        _ -> 
            {MinNode, NewR} = find_min(R),
            #node{val = MinNode, left = L, right = NewR}
    end.

find_min(#node{val = Val, left = null, right = R}) -> 
    {Val, R};
find_min(#node{val = Val, left = L, right = R}) -> 
    find_min(L).

search(null, _) -> false;
search(#node{val = Val, left = L, right = R}, X) when X < Val -> 
    search(L, X);
search(#node{val = Val, left = L, right = R}, X) when X > Val -> 
    search(R, X);
search(#node{val = Val, left = L, right = R}, Val) -> 
    true.