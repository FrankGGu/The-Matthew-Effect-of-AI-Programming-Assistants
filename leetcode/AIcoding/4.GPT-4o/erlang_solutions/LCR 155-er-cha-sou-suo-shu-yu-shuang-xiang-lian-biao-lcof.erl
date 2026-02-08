-module(solution).
-export([treeToDoublyList/1]).

-record(node, {val, left, right}).

treeToDoublyList(Root) ->
    {Head, Tail} = treeToDoublyListHelper(Root, null, null),
    case Head of
        null -> null;
        _ -> Head#node{left = Tail, right = Head}
    end.

treeToDoublyListHelper(null, Prev, Last) -> {Last, Prev};
treeToDoublyListHelper(Node, Prev, Last) ->
    {Head, Tail} = treeToDoublyListHelper(Node#node.left, Prev, Node),
    NewLast = case Head of
        null -> Node;
        _ -> Head
    end,
    NewPrev = case Last of
        null -> Node;
        _ -> Last
    end,
    Node#node{left = NewPrev, right = Head},
    treeToDoublyListHelper(Node#node.right, Node, NewLast).