-spec tree2str(T :: #tree_node{} | null) -> unicode:unicode_binary().
tree2str(null) ->
    <<>>;
tree2str(#tree_node{val = Val, left = null, right = null}) ->
    integer_to_binary(Val);
tree2str(#tree_node{val = Val, left = Left, right = null}) ->
    <<(integer_to_binary(Val))/binary, "(", (tree2str(Left))/binary, ")">>;
tree2str(#tree_node{val = Val, left = null, right = Right}) ->
    <<(integer_to_binary(Val))/binary, "()(", (tree2str(Right))/binary, ")">>;
tree2str(#tree_node{val = Val, left = Left, right = Right}) ->
    <<(integer_to_binary(Val))/binary, "(", (tree2str(Left))/binary, ")(", (tree2str(Right))/binary, ")">>.