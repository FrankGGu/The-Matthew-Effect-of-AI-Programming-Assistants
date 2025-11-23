-module(construct_tree).
-export([buildTree/2]).

buildTree(Inorder, Postorder) ->
  buildTree(Inorder, Postorder, 1, length(Inorder)).

buildTree(Inorder, Postorder, Start, End) when Start > End ->
  [];
buildTree(Inorder, Postorder, Start, End) ->
  RootVal = lists:last(Postorder),
  RootIndex = lists:keyfind(RootVal, 1, lists:zip(Inorder, lists:seq(1, length(Inorder)))),
  {_, Index} = RootIndex,
  LeftSize = Index - Start,
  {
    RootVal,
    buildTree(Inorder, lists:sublist(Postorder, 1, LeftSize), Start, Index - 1),
    buildTree(Inorder, lists:sublist(Postorder, LeftSize + 1, End - Index), Index + 1, End)
  }.