-module(next_greater_node).
-export([next_larger_nodes/1]).

next_larger_nodes(Head) ->
  List = to_list(Head),
  N = length(List),
  Result = lists:map(fun(X) -> -1 end, List),
  Stack = [],
  next_larger_nodes_helper(List, 0, Stack, Result, N).

next_larger_nodes_helper(_List, N, _Stack, Result, N) ->
  Result;
next_larger_nodes_helper(List, I, Stack, Result, N) ->
  Value = lists:nth(I + 1, List),
  {NewStack, NewResult} = process_stack(List, Value, Stack, Result),
  next_larger_nodes_helper(List, I + 1, [I | NewStack], NewResult, N).

process_stack(_List, _Value, [], Result) ->
  {[], Result};
process_stack(List, Value, [Top | Rest], Result) ->
  TopValue = lists:nth(Top + 1, List),
  if
    TopValue < Value ->
      NewResult = lists:nthreplace(Top + 1, Result, Value),
      process_stack(List, Value, Rest, NewResult)
    true ->
      {[Top | Rest], Result}
  end.

to_list(Head) ->
  to_list_helper(Head, []).

to_list_helper(null, Acc) ->
  lists:reverse(Acc);
to_list_helper(Node, Acc) ->
  to_list_helper(Node#node.next, [Node#node.val | Acc]).

-record(node, {val, next}).