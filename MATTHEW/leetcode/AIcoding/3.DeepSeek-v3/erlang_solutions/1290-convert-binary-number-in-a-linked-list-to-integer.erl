-spec get_decimal_value(Head :: #list_node{} | null) -> integer().
get_decimal_value(null) -> 0;
get_decimal_value(Head) ->
    get_decimal_helper(Head, 0).

get_decimal_helper(null, Acc) -> Acc;
get_decimal_helper(Node, Acc) ->
    NewAcc = (Acc bsl 1) bor Node#list_node.val,
    get_decimal_helper(Node#list_node.next, NewAcc).