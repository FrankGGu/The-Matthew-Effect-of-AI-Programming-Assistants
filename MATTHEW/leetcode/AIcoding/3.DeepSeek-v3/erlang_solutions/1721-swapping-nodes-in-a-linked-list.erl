-spec swap_nodes(Head :: #list_node{} | null, K :: integer()) -> #list_node{} | null.
swap_nodes(Head, K) ->
    case Head of
        null -> null;
        _ ->
            {First, Second} = find_nodes(Head, K),
            Temp = First#list_node.val,
            First#list_node{val = Second#list_node.val},
            Second#list_node{val = Temp},
            Head
    end.

find_nodes(Head, K) ->
    Length = length_of_list(Head),
    K2 = Length - K + 1,
    {find_node(Head, K), find_node(Head, K2)}.

find_node(Head, K) ->
    find_node(Head, K, 1).

find_node(Node, K, Pos) when Pos =:= K ->
    Node;
find_node(Node, K, Pos) ->
    find_node(Node#list_node.next, K, Pos + 1).

length_of_list(Head) ->
    length_of_list(Head, 0).

length_of_list(null, Acc) ->
    Acc;
length_of_list(Node, Acc) ->
    length_of_list(Node#list_node.next, Acc + 1).