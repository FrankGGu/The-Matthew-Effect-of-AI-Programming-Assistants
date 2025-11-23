-module(codec).
-export([serialize/1, deserialize/1]).

-spec serialize(TreeNode()) -> unicode:unicode_binary().
serialize(null) -> "null,";
serialize(Node) ->
    integer_to_list(Node#tree_node.val) ++ "," ++
    serialize(Node#tree_node.left) ++
    serialize(Node#tree_node.right).

-spec deserialize(unicode:unicode_binary()) -> TreeNode().
deserialize(Data) ->
    deserialize_helper(string:split(Data, ",", all)).

deserialize_helper(["null" | Rest]) ->
    {null, Rest};
deserialize_helper([Value | Rest]) ->
    {Val, _} = string:to_integer(Value),
    {Left, Rest1} = deserialize_helper(Rest),
    {Right, Rest2} = deserialize_helper(Rest1),
    {#tree_node{val = Val, left = Left, right = Right}, Rest2}.

-type TreeNode() :: null | #tree_node{val :: integer(), left :: TreeNode(), right :: TreeNode()}.
-record(tree_node, {val, left, right}).