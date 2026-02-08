-record(node, {val = 0 :: integer(),
               next = null :: 'null' | #node{},
               random = null :: 'null' | #node{}}).

-spec copy_random_list(Head :: #node{} | null) -> #node{} | null.
copy_random_list(null) -> null;
copy_random_list(Head) ->
    Map = maps:new(),
    {NewHead, Map1} = copy_nodes(Head, Map),
    {_, Map2} = update_random(Head, NewHead, Map1),
    NewHead.

copy_nodes(null, Map) -> {null, Map};
copy_nodes(Node, Map) ->
    NewNode = #node{val = Node#node.val},
    Map1 = maps:put(Node, NewNode, Map),
    {NewNext, Map2} = copy_nodes(Node#node.next, Map1),
    NewNode1 = NewNode#node{next = NewNext},
    {NewNode1, Map2}.

update_random(null, _, Map) -> {null, Map};
update_random(OldNode, NewNode, Map) ->
    case OldNode#node.random of
        null ->
            NewNode1 = NewNode#node{random = null},
            {NewNext, Map1} = update_random(OldNode#node.next, NewNode#node.next, Map),
            {NewNode1#node{next = NewNext}, Map1};
        Random ->
            NewRandom = maps:get(Random, Map),
            NewNode1 = NewNode#node{random = NewRandom},
            {NewNext, Map1} = update_random(OldNode#node.next, NewNode#node.next, Map),
            {NewNode1#node{next = NewNext}, Map1}
    end.