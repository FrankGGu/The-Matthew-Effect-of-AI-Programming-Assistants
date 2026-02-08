-module(solve).
-export([sum_even_grandparent/1]).

sum_even_grandparent(Root) ->
    sum_even_grandparent(Root, null, null).

sum_even_grandparent(null, _, _) ->
    0;
sum_even_grandparent(#{} = Node, Parent, GrandParent) ->
    Value = maps:get(value, Node),
    Left = maps:get(left, Node, null),
    Right = maps:get(right, Node, null),
    Sum = case GrandParent of
              null -> 0;
              _ when (GrandParent rem 2) == 0 -> Value;
              _ -> 0
          end,
    LeftSum = sum_even_grandparent(Left, Value, Parent),
    RightSum = sum_even_grandparent(Right, Value, Parent),
    Sum + LeftSum + RightSum.