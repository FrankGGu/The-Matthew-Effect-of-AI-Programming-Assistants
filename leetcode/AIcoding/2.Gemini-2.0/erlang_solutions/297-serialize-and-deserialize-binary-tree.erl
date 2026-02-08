-module(codec).
-export([serialize/1, deserialize/1]).

serialize(Root) ->
  serialize_helper(Root, []).

deserialize(Data) ->
  {Root, _} = deserialize_helper(Data, []),
  Root.

serialize_helper(null, Acc) ->
  [null | Acc];
serialize_helper(Node, Acc) ->
  [Node#tree.val | serialize_helper(Node#tree.left, serialize_helper(Node#tree.right, Acc))].

deserialize_helper([null | Tail], Acc) ->
  {null, Tail};
deserialize_helper([Val | Tail], Acc) ->
  {Left, Tail1} = deserialize_helper(Tail, Acc),
  {Right, Tail2} = deserialize_helper(Tail1, Acc),
  {tree(Val, Left, Right), Tail2}.

-record(tree, {val, left, right}).