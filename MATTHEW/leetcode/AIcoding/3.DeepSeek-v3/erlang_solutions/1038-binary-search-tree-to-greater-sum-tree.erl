-spec bst_to_gst(TreeNode :: #{} | null) -> #{} | null.
bst_to_gst(Root) ->
    {_, NewRoot} = traverse(Root, 0),
    NewRoot.

traverse(null, Sum) -> {Sum, null};
traverse(Node, Sum) ->
    {RightSum, Right} = traverse(maps:get(<<"right">>, Node, null), Sum),
    NewVal = RightSum + maps:get(<<"val">>, Node),
    {LeftSum, Left} = traverse(maps:get(<<"left">>, Node, null), NewVal),
    NewNode = Node#{<<"val">> => NewVal, <<"left">> => Left, <<"right">> => Right},
    {LeftSum, NewNode}.