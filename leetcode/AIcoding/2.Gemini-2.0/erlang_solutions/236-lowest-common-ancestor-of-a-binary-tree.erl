-module(lca).
-export([lowestCommonAncestor/3]).

lowestCommonAncestor(Root, P, Q) ->
  findLCA(Root, P, Q).

findLCA(null, _, _) ->
  null;
findLCA(Node, P, Q) ->
  if
    Node =:= null ->
      null;
    Node =:= P orelse Node =:= Q ->
      Node;
    true ->
      Left = findLCA(Node#tree.left, P, Q),
      Right = findLCA(Node#tree.right, P, Q),
      if
        Left =/= null andalso Right =/= null ->
          Node;
        Left =/= null ->
          Left;
        Right =/= null ->
          Right;
        true ->
          null
      end
  end.