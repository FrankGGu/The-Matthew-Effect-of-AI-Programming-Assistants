-module(bst_range_sum).
-export([range_sum_bst/2]).

range_sum_bst(undefined, _) -> 0;
range_sum_bst(#{} = Node, [L, R]) ->
    Val = maps:get(val, Node),
    Left = maps:get(left, Node, undefined),
    Right = maps:get(right, Node, undefined),
    Sum = case Val of
              V when V >= L, V =< R -> V;
              _ -> 0
          end,
    Sum + range_sum_bst(Left, [L, R]) + range_sum_bst(Right, [L, R]).