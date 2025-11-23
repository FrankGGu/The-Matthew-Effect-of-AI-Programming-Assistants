-module(min_distance_bst).
-export([min_diff_in_bst/1]).

min_diff_in_bst(Root) ->
  {_, MinDiff} = inorder(Root, [], infinity).

inorder(null, Acc, MinDiff) ->
  {Acc, MinDiff};
inorder(Node, Acc, MinDiff) ->
  {LeftAcc, LeftMinDiff} = inorder(Node#tree.left, Acc, MinDiff),
  case LeftAcc of
    [] ->
      NewAcc = [Node#tree.val],
      {NewAcc, LeftMinDiff};
    [PrevVal | _] ->
      Diff = abs(Node#tree.val - PrevVal),
      NewMinDiff = min(LeftMinDiff, Diff),
      NewAcc = [Node#tree.val | LeftAcc],
      {NewAcc, NewMinDiff}
  end,
  {RightAcc, RightMinDiff} = inorder(Node#tree.right, NewAcc, NewMinDiff),
  {RightAcc, RightMinDiff}.

-record(tree, {val, left, right}).