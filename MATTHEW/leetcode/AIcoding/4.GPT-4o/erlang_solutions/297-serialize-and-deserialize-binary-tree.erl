%% Definition for a binary tree node.
%% -record(tree_node, {val = 0 :: integer(), left = null :: 'null' | #tree_node{}, right = null :: 'null' | #tree_node{}}).

-spec serialize(Root :: #tree_node{} | null) -> string().
serialize(null) -> "[]";
serialize(#tree_node{val = Val, left = Left, right = Right}) ->
    lists:concat([integer_to_list(Val), ",", serialize(Left), ",", serialize(Right)]).

-spec deserialize(Data :: string()) -> #tree_node{} | null.
deserialize("[]") -> null;
deserialize(Data) ->
    deserialize(Data, []).

deserialize(<<>>, Tree) -> 
    case lists:reverse(Tree) of
        [] -> null;
        [Val | Rest] -> #tree_node{val = Val, left = null, right = deserialize(Rest)}
    end.

deserialize(<<S::size(8)>>, Tree) -> 
    deserialize(Data, tree)
