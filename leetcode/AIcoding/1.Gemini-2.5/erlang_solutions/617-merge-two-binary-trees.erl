-record(tree_node, {val=0, left=nil, right=nil}).

-spec merge_trees(T1 :: tree_node() | nil, T2 :: tree_node() | nil) -> tree_node() | nil.
merge_trees(nil, nil) -> nil;
merge_trees(nil, T2) -> T2;
merge_trees(T1, nil) -> T1;
merge_trees(#tree_node{val=Val1, left=Left1, right=Right1}, #tree_node{val=Val2, left=Left2, right=Right2}) ->
    #tree_node{
        val = Val1 + Val2,
        left = merge_trees(Left1, Left2),
        right = merge_trees(Right1, Right2)
    }.