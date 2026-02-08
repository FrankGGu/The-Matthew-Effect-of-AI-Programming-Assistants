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
            {Level, NewQueue} = dequeue_level(Queue, queue:new(), []),
            set_next_pointers(Level),
            connect_helper(NewQueue)
    end.

dequeue_level(Queue, NewQueue, Level) ->
    case queue:is_empty(Queue) of
        true -> {Level, NewQueue};
        false ->
            {{value, Node}, Q} = queue:out(Queue),
            NewLevel = [Node | Level],
            UpdatedNewQueue = case Node#node.left of
                                null -> NewQueue;
                                Left -> queue:in(Left, NewQueue)
                              end,
            FinalNewQueue = case Node#node.right of
                              null -> UpdatedNewQueue;
                              Right -> queue:in(Right, UpdatedNewQueue)
                            end,
            dequeue_level(Q, FinalNewQueue, NewLevel)
    end.

set_next_pointers([]) -> ok;
set_next_pointers([_]) -> ok;
set_next_pointers([First, Second | Rest]) ->
    First#node{next = Second},
    set_next_pointers([Second | Rest]).