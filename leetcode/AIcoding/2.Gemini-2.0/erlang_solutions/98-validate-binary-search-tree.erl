-module(validate_bst).
-export([is_valid_bst/1]).

-spec is_valid_bst(TreeNode()) -> boolean().
is_valid_bst(Root) ->
    is_valid_bst(Root, undefined, undefined).

-spec is_valid_bst(TreeNode(), integer() | undefined, integer() | undefined) -> boolean().
is_valid_bst(undefined, _, _) ->
    true;
is_valid_bst({Val, Left, Right}, Min, Max) ->
    (Min == undefined orelse Val > Min) and
    (Max == undefined orelse Val < Max) and
    is_valid_bst(Left, Min, Val) and
    is_valid_bst(Right, Val, Max).