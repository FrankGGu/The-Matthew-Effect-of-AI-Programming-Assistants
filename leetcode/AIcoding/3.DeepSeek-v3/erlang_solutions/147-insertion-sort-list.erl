-spec insertion_sort_list(Head :: #list_node{} | null) -> #list_node{} | null.
insertion_sort_list(null) -> null;
insertion_sort_list(Head) ->
    Dummy = #list_node{val = -1, next = null},
    insert(Head, Dummy).

insert(null, Sorted) -> Sorted#list_node.next;
insert(Node, Sorted) ->
    NextNode = Node#list_node.next,
    {Prev, Current} = find_insert_pos(Sorted, Node#list_node.val),
    Node1 = Node#list_node{next = Current},
    Prev#list_node{next = Node1},
    insert(NextNode, Sorted).

find_insert_pos(Sorted, Val) ->
    find_insert_pos(Sorted, Sorted#list_node.next, Val).

find_insert_pos(Prev, null, _Val) -> {Prev, null};
find_insert_pos(Prev, Current, Val) when Current#list_node.val >= Val -> {Prev, Current};
find_insert_pos(_Prev, Current, Val) ->
    find_insert_pos(Current, Current#list_node.next, Val).