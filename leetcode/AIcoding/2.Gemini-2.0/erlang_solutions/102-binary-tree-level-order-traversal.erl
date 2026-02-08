-module(solution).
-export([levelOrder/1]).

levelOrder(Root) ->
  levelOrderHelper([Root], []).

levelOrderHelper([], Acc) ->
  lists:reverse(Acc);
levelOrderHelper(Nodes, Acc) ->
  Values = [node_val(Node) || Node <- Nodes, is_node(Node)],
  NextLevel = [get_children(Node) || Node <- Nodes, is_node(Node)],
  NextLevelNodes = lists:flatten(NextLevel),
  levelOrderHelper(NextLevelNodes, [Values | Acc]).

node_val(null) -> null;
node_val({_, Val, _}) -> Val.

is_node(null) -> false;
is_node(_) -> true.

get_children(null) -> [];
get_children({Left, _, Right}) ->
  [Left, Right].