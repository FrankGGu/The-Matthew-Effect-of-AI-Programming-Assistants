-spec is_sub_path(Head :: #list_node{} | null, Root :: #tree_node{} | null) -> boolean().
is_sub_path(Head, Root) ->
    case Head of
        null -> true;
        _ ->
            case Root of
                null -> false;
                _ ->
                    check_path(Head, Root) orelse
                    is_sub_path(Head, Root#tree_node.left) orelse
                    is_sub_path(Head, Root#tree_node.right)
            end
    end.

check_path(Head, Root) ->
    case Head of
        null -> true;
        _ ->
            case Root of
                null -> false;
                _ ->
                    (Head#list_node.val =:= Root#tree_node.val) andalso
                    (check_path(Head#list_node.next, Root#tree_node.left) orelse
                     check_path(Head#list_node.next, Root#tree_node.right))
            end
    end.