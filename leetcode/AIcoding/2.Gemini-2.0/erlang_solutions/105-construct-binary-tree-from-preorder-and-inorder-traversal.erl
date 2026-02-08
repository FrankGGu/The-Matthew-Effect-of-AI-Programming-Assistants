-module(construct_binary_tree).
-export([build_tree/2]).

-record(tree_node, {val, left, right}).

build_tree(Preorder, Inorder) ->
    build_tree_helper(Preorder, Inorder, 1, length(Preorder), 1, length(Inorder)).

build_tree_helper(Preorder, Inorder, PreStart, PreEnd, InStart, InEnd) ->
    if PreStart > PreEnd ->
        null;
    true ->
        Val = lists:nth(PreStart, Preorder),
        Index = find_index(Inorder, Val, InStart),
        LeftSize = Index - InStart,
        Left = build_tree_helper(Preorder, Inorder, PreStart + 1, PreStart + LeftSize, InStart, Index - 1),
        Right = build_tree_helper(Preorder, Inorder, PreStart + LeftSize + 1, PreEnd, Index + 1, InEnd),
        #tree_node{val = Val, left = Left, right = Right}
    end.

find_index(List, Val, Start) ->
    find_index_helper(List, Val, Start, 1).

find_index_helper(List, Val, Index, Count) ->
    if lists:nth(Index, List) == Val ->
        Count;
    true ->
        find_index_helper(List, Val, Index + 1, Count + 1)
    end.