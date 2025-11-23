%% Definition for a binary tree node.
%% -record(tree_node, {val = 0 :: integer(),
%%                     left = null  :: 'null' | #tree_node{},
%%                     right = null :: 'null' | #tree_node{}}).

-spec build_tree(Preorder :: [integer()], Inorder :: [integer()]) -> #tree_node{} | null.
build_tree([], _) -> null;
build_tree([Root | Preorder], Inorder) ->
    {LeftInorder, [Root | RightInorder]} = split_inorder(Inorder, Root),
    LeftPreorder = lists:prefix(LeftInorder, Preorder),
    LeftTree = build_tree(LeftPreorder, LeftInorder),
    RightTree = build_tree(Preorder -- LeftPreorder, RightInorder),
    #tree_node{val = Root, left = LeftTree, right = RightTree}.

-spec split_inorder(Inorder :: [integer()], Root :: integer()) -> {[integer()], [integer()]}.
split_inorder([], _) -> {[], []};
split_inorder([Root | RightInorder], Root) -> {[], RightInorder};
split_inorder([Val | Inorder], Root) ->
    case Val == Root of
        true -> {[], Inorder};
        false -> 
            {Left, Right} = split_inorder(Inorder, Root),
            {[Val | Left], Right}
    end.
