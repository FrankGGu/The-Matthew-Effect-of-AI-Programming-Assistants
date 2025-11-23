-record(node, {val = 0 :: integer(),
               next = null :: 'null' | #node{},
               random = null :: 'null' | #node{}}).

-spec copy_random_list(Head :: #node{} | null) -> #node{} | null.
copy_random_list(null) -> null;
copy_random_list(Head) ->
    % First pass: create new nodes and interleave them with the original list
    Current = Head,
    while_create(Current),

    % Second pass: set the random pointers for the new nodes
    Current1 = Head,
    while_set_random(Current1),

    % Third pass: separate the new list from the original list
    NewHead = Head#node.next,
    Current2 = NewHead,
    while_separate(Current2),

    NewHead.

while_create(null) -> ok;
while_create(Node) ->
    NewNode = #node{val = Node#node.val, next = Node#node.next},
    Node#node.next = NewNode,
    while_create(NewNode#node.next).

while_set_random(null) -> ok;
while_set_random(Node) ->
    case Node#node.random of
        null -> NewNodeRandom = null;
        Random -> NewNodeRandom = Random#node.next
    end,
    NewNode = Node#node.next,
    NewNode#node.random = NewNodeRandom,
    while_set_random(NewNode#node.next).

while_separate(null) -> ok;
while_separate(Node) ->
    NextOriginal = case Node#node.next of
                       null -> null;
                       Next -> Next#node.next
                   end,
    Node#node.next = NextOriginal,
    while_separate(NextOriginal).