-record('TreeNode', {val, left, right}).

-spec treeToDoublyList('TreeNode' | nil) -> 'TreeNode' | nil.
treeToDoublyList(nil) -> nil;
treeToDoublyList(Root) ->
    HeadRef = #{'TreeNode'}{val = nil, left = nil, right = nil},
    PrevRef = #{'TreeNode'}{val = nil, left = nil, right = nil},

    inorder(Root, HeadRef, PrevRef),

    Head = HeadRef#TreeNode.right,
    Tail = PrevRef#TreeNode.right,

    erlang:setelement(2, Head, Tail),
    erlang:setelement(3, Tail, Head),

    Head.

inorder(nil, _HeadRef, _PrevRef) -> ok;
inorder(Node, HeadRef, PrevRef) ->
    inorder(Node#TreeNode.left, HeadRef, PrevRef),

    case PrevRef#TreeNode.right of
        nil ->
            erlang:setelement(3, HeadRef, Node);
        PrevNode ->
            erlang:setelement(2, Node, PrevNode),
            erlang:setelement(3, PrevNode, Node)
    end,
    erlang:setelement(3, PrevRef, Node),

    inorder(Node#TreeNode.right, HeadRef, PrevRef).