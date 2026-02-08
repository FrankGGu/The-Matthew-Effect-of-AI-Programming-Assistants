-module(level_order).
-export([levelOrder/1]).

-record(node, {val, children}).

levelOrder(Root) ->
  levelOrderHelper([Root], []).

levelOrderHelper([], Acc) ->
  lists:reverse(Acc);
levelOrderHelper(Nodes, Acc) ->
  Vals = [Node#node.val || Node <- Nodes, Node /= null],
  NextLevelNodes = [Child || Node <- Nodes, Node /= null, Child <- Node#node.children],
  levelOrderHelper(NextLevelNodes, [Vals | Acc]).