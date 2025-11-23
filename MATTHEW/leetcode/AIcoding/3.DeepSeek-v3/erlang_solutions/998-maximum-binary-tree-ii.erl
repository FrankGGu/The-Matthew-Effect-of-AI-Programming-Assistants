-spec insert_into_max_tree(Root :: #{} | null, Val :: integer()) -> #{} | null.
insert_into_max_tree(null, Val) ->
    #{val => Val, left => null, right => null};
insert_into_max_tree(#{val := V, right := Right} = Node, Val) when V < Val ->
    #{val => Val, left => Node, right => null};
insert_into_max_tree(#{right := Right} = Node, Val) ->
    Node#{right := insert_into_max_tree(Right, Val)}.