-module(largest_values).
-export([largest_values/1]).

largest_values(Root) ->
  largest_values_helper([Root], []).

largest_values_helper([], Acc) ->
  lists:reverse(Acc);
largest_values_helper(Nodes, Acc) ->
  Max = lists:max([Node#node.val || Node <- Nodes]),
  NextLevel = [Child || Node <- Nodes, Child <- get_children(Node)],
  largest_values_helper(NextLevel, [Max | Acc]).

get_children(nil) ->
  [];
get_children(#node{left = Left, right = Right}) ->
  lists:filter(fun(X) -> X /= nil end, [Left, Right]).