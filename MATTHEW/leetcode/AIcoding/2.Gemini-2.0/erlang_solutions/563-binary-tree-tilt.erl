-module(binary_tree_tilt).
-export([findTilt/1]).

-record(tree_node, {val, left, right}).

findTilt(Root) ->
  {_, Tilt} = tilt(Root, 0),
  Tilt.

tilt(nil, Acc) ->
  {0, Acc};
tilt(#tree_node{val = Val, left = Left, right = Right}, Acc) ->
  {LeftSum, LeftTilt} = tilt(Left, Acc),
  {RightSum, RightTilt} = tilt(Right, LeftTilt),
  Sum = Val + LeftSum + RightSum,
  Tilt = abs(LeftSum - RightSum) + RightTilt,
  {Sum, Tilt}.