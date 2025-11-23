-module(lca_bst).
-export([lowestCommonAncestor/3]).

lowestCommonAncestor(Root, P, Q) ->
  case Root of
    null ->
      null;
    _ ->
      Val = element(1, Root),
      PV = element(1, P),
      QV = element(1, Q),

      if PV > Val and QV > Val ->
        lowestCommonAncestor(element(3, Root), P, Q);
      elseif PV < Val and QV < Val ->
        lowestCommonAncestor(element(2, Root), P, Q);
      else
        Root
      end
  end.