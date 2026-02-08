-module(solution).
-export([merge_trees/2]).

-record(tree, {val=0, left=null, right=null}).

merge_trees(null, T) -> T;
merge_trees(T, null) -> T;
merge_trees(T1, T2) ->
    NewVal = T1#tree.val + T2#tree.val,
    Left = merge_trees(T1#tree.left, T2#tree.left),
    Right = merge_trees(T1#tree.right, T2#tree.right),
    #tree{val=NewVal, left=Left, right=Right}.