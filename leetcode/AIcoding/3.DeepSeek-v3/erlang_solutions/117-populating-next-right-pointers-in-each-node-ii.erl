-record(node, {val = 0 :: integer(),
               left = null  :: 'null' | #node{},
               right = null :: 'null' | #node{},
               next = null :: 'null' | #node{}}).

-spec connect(Root :: #node{} | null) -> #node{} | null.
connect(null) -> null;
connect(Root) ->
    Queue = queue:in(Root, queue:new()),
    connect_helper(Queue).

connect_helper(Queue) ->
    case queue:is_empty(Queue) of
        true -> ok;
        false ->
            {Node, Q1} = queue:out(Queue),
            Size = queue:len(Q1),
            connect_level(Node, Q1, Size)
    end.

connect_level(Node, Queue, 0) ->
    Node#node{next = null},
    NewQueue = case Node#node.left of
                  null -> Queue;
                  Left -> queue:in(Left, Queue)
               end,
    NewQueue1 = case Node#node.right of
                   null -> NewQueue;
                   Right -> queue:in(Right, NewQueue)
                end,
    connect_helper(NewQueue1);
connect_level(Node, Queue, Size) ->
    {NextNode, Q1} = queue:out(Queue),
    Node#node{next = NextNode},
    NewQueue = case Node#node.left of
                  null -> Q1;
                  Left -> queue:in(Left, Q1)
               end,
    NewQueue1 = case Node#node.right of
                   null -> NewQueue;
                   Right -> queue:in(Right, NewQueue)
                end,
    connect_level(NextNode, NewQueue1, Size - 1).