-module(leetcode).
-export([lowestCommonAncestor/3]).

-record(tree_node, {val, left = nil, right = nil}).

lowestCommonAncestor(Root = #tree_node{val = RootVal, left = Left, right = Right},
                     P = #tree_node{val = PVal},
                     Q = #tree_node{val = QVal}) ->
    if
        PVal < RootVal andalso QVal < RootVal ->
            lowestCommonAncestor(Left, P, Q);
        PVal > RootVal andalso QVal > RootVal ->
            lowestCommonAncestor(Right, P, Q);
        true ->
            Root
    end.