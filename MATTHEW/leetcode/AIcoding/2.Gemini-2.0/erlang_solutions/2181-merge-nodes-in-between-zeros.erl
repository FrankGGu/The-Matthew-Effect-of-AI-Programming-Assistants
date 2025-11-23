-module(merge_nodes_in_between_zeros).
-export([mergeNodes/1]).

-record(list_node, {val, next}).

mergeNodes(Head) ->
  mergeNodesHelper(Head, 0, []).

mergeNodesHelper(null, Sum, Acc) ->
  lists:reverse(Acc);
mergeNodesHelper(Node, Sum, Acc) ->
  Val = Node#list_node.val,
  Next = Node#list_node.next,
  case Val of
    0 ->
      case Sum of
        0 ->
          mergeNodesHelper(Next, 0, Acc);
        _ ->
          NewNode = #list_node{val = Sum, next = null},
          mergeNodesHelper(Next, 0, [NewNode | Acc])
      end;
    _ ->
      mergeNodesHelper(Next, Sum + Val, Acc)
  end.