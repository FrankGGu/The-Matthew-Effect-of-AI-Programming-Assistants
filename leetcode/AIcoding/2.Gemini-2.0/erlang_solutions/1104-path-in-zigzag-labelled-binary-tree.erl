-module(pathInZigZagTree).
-export([pathInZigZagTree/1]).

pathInZigZagTree(Label) ->
  Level = floor(math:log(Label, 2)) + 1,
  pathInZigZagTree(Label, Level, []).

pathInZigZagTree(1, _, Acc) ->
  lists:reverse([1 | Acc]);
pathInZigZagTree(Label, Level, Acc) ->
  Parent = getParent(Label, Level),
  NewAcc = [Parent | Acc],
  pathInZigZagTree(Parent, Level - 1, NewAcc).

getParent(Label, Level) ->
  MaxValue = math:pow(2, Level - 1) - 1 + math:pow(2, Level - 2),
  MinValue = math:pow(2, Level - 2),
  ReversedLabel = MaxValue - Label + MinValue,
  ReversedLabel div 2.