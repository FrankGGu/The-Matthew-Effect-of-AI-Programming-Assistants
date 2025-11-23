-module(bst_to_sorted_dll).
-export([treeToDoublyList/1]).

-spec treeToDoublyList(TreeNode()) -> TreeNode().
treeToDoublyList(Root) ->
  {First, Last} = inOrder(Root, null, null),
  if First == null ->
    null
  else
    First ! first,
    Last ! last,
    First
  end.

inOrder(null, AccFirst, AccLast) ->
  {AccFirst, AccLast};
inOrder(Node, AccFirst, AccLast) ->
  {NewFirst, LeftLast} = inOrder(Node ! left, AccFirst, AccLast),
  NewFirstFirst = case NewFirst of
                    null -> Node;
                    _ -> NewFirst
                  end,
  if LeftLast /= null ->
    LeftLast ! right = Node,
    Node ! left = LeftLast
  else
    true
  end,
  {NewFirstFirst, RightLast} = inOrder(Node ! right, NewFirstFirst, Node),
  {NewFirstFirst, RightLast}.