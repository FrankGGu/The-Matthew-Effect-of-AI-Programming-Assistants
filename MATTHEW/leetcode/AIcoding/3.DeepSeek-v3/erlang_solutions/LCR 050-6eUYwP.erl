-record(treeNode, {val = 0 :: integer(),
                   left = null  :: 'null' | #treeNode{},
                   right = null :: 'null' | #treeNode{}}).

-spec path_sum(Root :: #treeNode{} | null, TargetSum :: integer()) -> integer().
path_sum(Root, TargetSum) ->
    case Root of
        null -> 0;
        _ -> 
            count_paths(Root, TargetSum) + 
            path_sum(Root#treeNode.left, TargetSum) + 
            path_sum(Root#treeNode.right, TargetSum)
    end.

-spec count_paths(Node :: #treeNode{} | null, Sum :: integer()) -> integer().
count_paths(Node, Sum) ->
    case Node of
        null -> 0;
        _ ->
            NewSum = Sum - Node#treeNode.val,
            (if NewSum == 0 -> 1; true -> 0 end) + 
            count_paths(Node#treeNode.left, NewSum) + 
            count_paths(Node#treeNode.right, NewSum)
    end.