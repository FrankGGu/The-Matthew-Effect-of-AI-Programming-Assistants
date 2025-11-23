-module(merge_trees).
-export([mergeTrees/2]).

-record(tree_node, {val, left, right}).

mergeTrees(T1, T2) ->
    merge(T1, T2).

merge(T1, T2) when is_atom(T1), is_atom(T2) ->
    null;
merge(T1, T2) when is_atom(T1) ->
    T2;
merge(T1, T2) when is_atom(T2) ->
    T1;
merge(T1, T2) ->
    #tree_node{val = T1#tree_node.val + T2#tree_node.val,
               left = merge(T1#tree_node.left, T2#tree_node.left),
               right = merge(T1#tree_node.right, T2#tree_node.right)}.