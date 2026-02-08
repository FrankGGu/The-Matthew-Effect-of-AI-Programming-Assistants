-spec get_target_copy(Original :: #tree_node{} | null,
                      Cloned :: #tree_node{} | null,
                      Target :: #tree_node{} | null) -> #tree_node{} | null.
get_target_copy(Original, Cloned, Target) ->
    case Original of
        null -> null;
        _ when Original =:= Target -> Cloned;
        _ ->
            case get_target_copy(Original#tree_node.left, Cloned#tree_node.left, Target) of
                null -> get_target_copy(Original#tree_node.right, Cloned#tree_node.right, Target);
                Found -> Found
            end
    end.