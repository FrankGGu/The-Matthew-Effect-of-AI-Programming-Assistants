-spec bst_from_preorder(Preorder :: [integer()]) -> TreeNode | nil.
bst_from_preorder(Preorder) ->
    {Tree, _} = build_tree(Preorder, {nil, infinity}),
    Tree.

build_tree([], {Tree, _}) ->
    {Tree, []};
build_tree([H | T], {Tree, Upper}) when H < Upper ->
    {Left, Rest1} = build_tree(T, {nil, H}),
    {Right, Rest2} = build_tree(Rest1, {nil, Upper}),
    {{H, Left, Right}, Rest2};
build_tree(List, {Tree, _}) ->
    {Tree, List}.