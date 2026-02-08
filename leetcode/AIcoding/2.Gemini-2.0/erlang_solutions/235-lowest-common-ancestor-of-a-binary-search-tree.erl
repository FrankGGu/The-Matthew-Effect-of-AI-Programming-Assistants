-module(lca_bst).
-export([lowestCommonAncestor/3]).

lowestCommonAncestor(Root, P, Q) ->
  lowestCommonAncestorHelper(Root, P, Q).

lowestCommonAncestorHelper(Root, P, Q) ->
  Val = element(1, Root),
  PV = element(1, P),
  QV = element(1, Q),
  if
    PV < Val and QV < Val ->
      lowestCommonAncestorHelper(element(2, Root), P, Q);
    PV > Val and QV > Val ->
      lowestCommonAncestorHelper(element(3, Root), P, Q);
    true ->
      Root
  end.