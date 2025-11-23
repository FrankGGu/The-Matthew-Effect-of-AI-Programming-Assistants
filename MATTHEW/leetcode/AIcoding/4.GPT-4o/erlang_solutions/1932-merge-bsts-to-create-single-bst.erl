-module(merge_bsts).
-export([merge_trees/2]).

-record(node, {val, left = none, right = none}).

merge_trees(Tree1, Tree2) ->
    Elements1 = inorder(Tree1, []),
    Elements2 = inorder(Tree2, []),
    MergedElements = lists:sort(Elements1 ++ Elements2),
    build_bst(MergedElements).

inorder(none, Acc) -> Acc;
inorder(#node{val=Val, left=Left, right=Right}, Acc) ->
    inorder(Left, [Val | inorder(Right, Acc)]).

build_bst([]) -> none;
build_bst(Elems) ->
    Middle = length(Elems) div 2,
    Val = lists:nth(Middle + 1, Elems),
    Left = lists:sublist(Elems, Middle),
    Right = lists:sublist(Elems, Middle + 2, length(Elems) - (Middle + 1)),
    #node{val=Val, left=build_bst(Left), right=build_bst(Right)}.