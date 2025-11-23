-module(solution).
-export([buildTree/2]).

-record(tree_node, {val, left = nil, right = nil}).

buildTree([], []) ->
    nil;
buildTree([RootVal | PreorderRest], Inorder) ->
    {LeftInorder, [_ | RightInorderRest]} = lists:splitwith(fun(X) -> X =/= RootVal end, Inorder),
    LenLeft = length(LeftInorder),
    LeftPreorder = lists:sublist(PreorderRest, 1, LenLeft),
    RightPreorder = lists:nthtail(LenLeft, PreorderRest),

    LeftChild = buildTree(LeftPreorder, LeftInorder),
    RightChild = buildTree(RightPreorder, RightInorderRest),

    #tree_node{val = RootVal, left = LeftChild, right = RightChild}.