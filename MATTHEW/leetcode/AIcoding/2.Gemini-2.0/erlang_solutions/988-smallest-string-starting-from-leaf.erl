-module(smallest_from_leaf).
-export([smallest_from_leaf/1]).

-record(node, {val, left, right}).

smallest_from_leaf(Root) ->
  smallest_from_leaf_helper(Root, "").

smallest_from_leaf_helper(null, Acc) ->
  "~";
smallest_from_leaf_helper(Node, Acc) ->
  V = Node#node.val,
  Char = list_to_binary([V + $a]),
  NewAcc = binary_to_list(Char) ++ Acc,
  Left = Node#node.left,
  Right = Node#node.right,
  LeftResult = smallest_from_leaf_helper(Left, NewAcc),
  RightResult = smallest_from_leaf_helper(Right, NewAcc),

  case {LeftResult =:= "~", RightResult =:= "~"} of
    {true, true} ->
      NewAcc;
    {false, true} ->
      LeftResult;
    {true, false} ->
      RightResult;
    {false, false} ->
      if LeftResult < RightResult ->
        LeftResult;
      true ->
        RightResult
      end
  end.