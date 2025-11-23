-module(second_minimum).
-export([find_second_minimum_value/1]).

find_second_minimum_value(Root) ->
  find_second_minimum_value(Root, Root#tree.val, infinity).

find_second_minimum_value(nil, _, SecondMin) ->
  SecondMin;
find_second_minimum_value(Node, Min, SecondMin) ->
  Val = Node#tree.val,
  case Val of
    Min ->
      Left = find_second_minimum_value(Node#tree.left, Min, SecondMin),
      Right = find_second_minimum_value(Node#tree.right, Min, Left),
      Right;
    _ when Val < Min ->
      SecondMin;
    _ ->
      NewSecondMin = min(Val, SecondMin),
      Left = find_second_minimum_value(Node#tree.left, Min, NewSecondMin),
      Right = find_second_minimum_value(Node#tree.right, Min, Left),
      Right
  end.

-record(tree, {val, left, right}).

min(A, B) ->
  if A < B -> A; true -> B end.

infinity() ->
  16#7fffffff#.