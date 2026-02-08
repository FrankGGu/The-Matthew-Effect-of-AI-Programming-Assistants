-module(binary_tree_coloring).
-export([winnerOfGame/1]).

winnerOfGame(Root) ->
  {RedCount, BlueCount} = color(Root, 0, 0),
  RedCount > BlueCount.

color(nil, Red, Blue) ->
  {Red, Blue};
color({Val, Left, Right}, Red, Blue) ->
  {LeftRed, LeftBlue} = color(Left, 0, 0),
  {RightRed, RightBlue} = color(Right, 0, 0),
  case Val rem 2 of
    0 -> {Red + LeftRed + RightRed, Blue + LeftBlue + RightBlue + 1};
    1 -> {Red + LeftRed + RightRed + 1, Blue + LeftBlue + RightBlue}
  end.