-module(lowestCommonAncestor).
-export([lowestCommonAncestor/3]).

lowestCommonAncestor(Root, P, Q) ->
  findLCA(Root, P, Q).

findLCA(null, _, _) ->
  null;
findLCA(Node, P, Q) ->
  case Node of
    #{val := Val} ->
      if
        Val == P#node.val orelse Val == Q#node.val ->
          Node;
        true ->
          LeftResult = findLCA(Node#node.left, P, Q),
          RightResult = findLCA(Node#node.right, P, Q),
          case {LeftResult, RightResult} of
            {null, null} ->
              null;
            {null, _} ->
              RightResult;
            {_, null} ->
              LeftResult;
            {_, _} ->
              Node
          end
      end
  end.