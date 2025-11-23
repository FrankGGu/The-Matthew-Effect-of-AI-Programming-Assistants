-module(balanced_binary_tree).
-export([is_balanced/1]).

-spec is_balanced(TreeNode()) -> boolean().
is_balanced(Root) ->
    case height_diff(Root) of
        {ok, _} -> true;
        error -> false
    end.

-spec height_diff(TreeNode()) -> {ok, integer()} | error.
height_diff(null) -> {ok, 0};
height_diff(Node) ->
    Left = height_diff(Node#treeNode.left),
    Right = height_diff(Node#treeNode.right),
    case {Left, Right} of
        {error, _} -> error;
        {_, error} -> error;
        {{ok, LHeight}, {ok, RHeight}} ->
            if abs(LHeight - RHeight) =< 1 ->
                {ok, max(LHeight, RHeight) + 1};
            true ->
                error
            end
    end.

-record(treeNode, {val, left, right}).