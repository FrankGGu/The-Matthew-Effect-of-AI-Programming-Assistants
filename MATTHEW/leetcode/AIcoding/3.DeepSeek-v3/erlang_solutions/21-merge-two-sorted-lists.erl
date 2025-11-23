-spec merge_two_lists(List1 :: #list_node{} | null, List2 :: #list_node{} | null) -> #list_node{} | null.
merge_two_lists(null, null) -> null;
merge_two_lists(null, L2) -> L2;
merge_two_lists(L1, null) -> L1;
merge_two_lists(L1, L2) ->
    if
        L1#list_node.val =< L2#list_node.val ->
            #list_node{val = L1#list_node.val, next = merge_two_lists(L1#list_node.next, L2)};
        true ->
            #list_node{val = L2#list_node.val, next = merge_two_lists(L1, L2#list_node.next)}
    end.