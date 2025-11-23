-module(deepest_leaves_sum).
-export([sum/1]).

sum(Tree) ->
    {Depth, Sum} = traverse(Tree, 0, 0),
    Sum.

traverse(nil, CurrentDepth, CurrentSum) ->
    {CurrentDepth, CurrentSum};
traverse({Val, Left, Right}, CurrentDepth, CurrentSum) ->
    {LeftDepth, LeftSum} = traverse(Left, CurrentDepth + 1, 0),
    {RightDepth, RightSum} = traverse(Right, CurrentDepth + 1, 0),
    if
        LeftDepth > RightDepth ->
            {LeftDepth, LeftSum + Val};
        RightDepth > LeftDepth ->
            {RightDepth, RightSum + Val};
        true ->
            {LeftDepth, LeftSum + RightSum + Val}
    end.