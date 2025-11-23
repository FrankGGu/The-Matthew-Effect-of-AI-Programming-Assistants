-module(is_balanced).
-export([is_balanced/1]).

is_balanced(Root) ->
    is_balanced_helper(Root, 0).

is_balanced_helper(null, Height) ->
    {true, Height};
is_balanced_helper(Node, Height) ->
    {LeftBalanced, LeftHeight} = is_balanced_helper(Node#tree.left, Height + 1),
    {RightBalanced, RightHeight} = is_balanced_helper(Node#tree.right, Height + 1),
    Balanced = LeftBalanced and RightBalanced and abs(LeftHeight - RightHeight) =< 1,
    {Balanced, max(LeftHeight, RightHeight)}.

-record(tree, {val, left, right}).