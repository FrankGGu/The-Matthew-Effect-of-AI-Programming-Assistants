-module(solution).
-export([buildTree/2]).

buildTree([], []) -> nil;
buildTree([RootVal | RestPreorder], Inorder) ->
    {LeftInorder, RightInorder} = split_inorder(RootVal, Inorder),
    LeftLen = length(LeftInorder),
    {LeftPreorder, RightPreorder} = split_preorder(RestPreorder, LeftLen),
    LeftChild = buildTree(LeftPreorder, LeftInorder),
    RightChild = buildTree(RightPreorder, RightInorder),
    {node, RootVal, LeftChild, RightChild}.

split_inorder(RootVal, Inorder) ->
    {Before, After} = lists:splitwith(fun(X) -> X /= RootVal end, Inorder),
    [_Root | RestAfter] = After,
    {Before, RestAfter}.

split_preorder(Preorder, LeftLen) ->
    lists:splitat(LeftLen, Preorder).