-module(kth_smallest).
-export([kth_smallest/2]).

kth_smallest(Root, K) ->
  inorder(Root, K, []).

inorder(null, _, Acc) ->
  {null, Acc};
inorder(Node, K, Acc) ->
  {LeftResult, LeftAcc} = inorder(Node#tree.left, K, Acc),
  case LeftResult of
    null ->
      NewAcc = [Node#tree.val | LeftAcc],
      case length(NewAcc) >= K of
        true ->
          {element(K, lists:reverse(NewAcc)), NewAcc};
        false ->
          inorder(Node#tree.right, K, NewAcc)
      end;
    _ ->
      {LeftResult, LeftAcc}
  end.

-record(tree, {val, left, right}).