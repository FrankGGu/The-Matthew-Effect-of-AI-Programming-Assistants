-module(n_ary_tree_postorder).
-export([postorder/1]).

-record(node, {val, children}).

postorder(Root) ->
  postorder_helper(Root, []).

postorder_helper(null, Acc) ->
  Acc;
postorder_helper(Node, Acc) ->
  Children = Node#node.children,
  Acc1 = lists:foldl(fun(Child, Acc0) -> postorder_helper(Child, Acc0) end, Acc, Children),
  [Node#node.val | Acc1].