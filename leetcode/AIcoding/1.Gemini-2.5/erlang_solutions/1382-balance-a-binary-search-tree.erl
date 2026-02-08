-module(solution).
-export([balanceBST/1]).

-record(treenode, {val, left, right}).

-spec balanceBST(Root :: treenode() | nil) -> treenode() | nil.
balanceBST(Root) ->
    SortedList = inorder(Root),
    build_bst_from_list(SortedList).

inorder(Root) -> inorder(Root, []).

inorder(nil, Acc) -> Acc;
inorder(#treenode{val=Val, left=Left, right=Right}, Acc) ->
    inorder(Left, [Val | inorder(Right, Acc)]).

build_bst_from_list(List) ->
    build_bst_from_list(List, length(List)).

build_bst_from_list(nil, 0) -> nil;
build_bst_from_list(List, Len) ->
    MidIdx = (Len - 1) div 2,
    {LeftList, [Val | RightList]} = lists:split(MidIdx, List),
    Left = build_bst_from_list(LeftList, MidIdx),
    Right = build_bst_from_list(RightList, Len - MidIdx - 1),
    #treenode{val=Val, left=Left, right=Right}.