-module(solution).
-export([connect/1]).

-record(node, {val, left, right, next = nil}).

connect(nil) -> nil;
connect(Root) ->
    connect_nodes(Root, nil).

connect_nodes(nil, _Next) -> nil;
connect_nodes(Node = #node{left = L, right = R}, Next) ->
    NodeWithNext = Node#node{next = Next},
    case {L, R} of
        {nil, nil} ->
            NodeWithNext;
        {#node{} = LeftChild, #node{} = RightChild} ->
            ConnectedLeft = connect_nodes(LeftChild, RightChild),

            NextRightChild = case Next of
                                 nil -> nil;
                                 #node{left = NextLeftOfParentNext} -> NextLeftOfParentNext
                             end,
            ConnectedRight = connect_nodes(RightChild, NextRightChild),

            NodeWithNext#node{left = ConnectedLeft, right = ConnectedRight}
    end.