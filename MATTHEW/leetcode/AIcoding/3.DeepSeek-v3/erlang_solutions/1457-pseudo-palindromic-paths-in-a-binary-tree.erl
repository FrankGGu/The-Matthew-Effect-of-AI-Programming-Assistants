-spec pseudo_palindromic_paths(Root :: #tree_node{} | null) -> integer().
pseudo_palindromic_paths(null) -> 0;
pseudo_palindromic_paths(Root) ->
    helper(Root, 0, 0).

helper(null, _Path, _Count) -> 0;
helper(Node, Path, Count) ->
    NewPath = Path bxor (1 bsl Node#tree_node.val),
    NewCount = case Node#tree_node.left =:= null andalso Node#tree_node.right =:= null of
        true ->
            case (NewPath band (NewPath - 1)) =:= 0 of
                true -> Count + 1;
                false -> Count
            end;
        false -> Count
    end,
    Left = helper(Node#tree_node.left, NewPath, NewCount),
    Right = helper(Node#tree_node.right, NewPath, NewCount),
    Left + Right.