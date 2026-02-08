%% Definition for a binary tree node.
%% -record(tree_node, {val = 0 :: integer(),
%%                     left = null  :: 'null' | #tree_node{},
%%                     right = null :: 'null' | #tree_node{}}).

-spec build_tree(Inorder :: [integer()], Postorder :: [integer()]) -> #tree_node{} | null.
build_tree([Root | InorderRest], Postorder) ->
    {LeftSubtree, PostorderLeft} = build_left_tree(InorderRest, Postorder, Root),
    {RightSubtree, _} = build_right_tree(InorderRest, PostorderLeft, Root),
    #tree_node{val = Root, left = LeftSubtree, right = RightSubtree}.

build_left_tree([], Postorder, _) -> {null, Postorder};
build_left_tree([Val | InorderRest], [Root | Rest], Root) ->
    build_left_tree(InorderRest, Rest, Val);
build_left_tree([_ | InorderRest], Rest, Root) -> build_left_tree(InorderRest, Rest, Root).

build_right_tree([], Postorder, _) -> {null, Postorder};
build_right_tree([Val | InorderRest], [Root | Rest], Root) ->
    build_right_tree(InorderRest, Rest, Val);
build_right_tree([_ | InorderRest], Rest, Root) -> build_right_tree(InorderRest, Rest, Root).
