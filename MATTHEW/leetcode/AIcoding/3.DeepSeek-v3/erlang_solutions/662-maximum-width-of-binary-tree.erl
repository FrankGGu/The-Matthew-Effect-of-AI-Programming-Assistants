-spec width_of_binary_tree(Root :: #tree_node{} | null) -> integer().
width_of_binary_tree(null) -> 0;
width_of_binary_tree(Root) ->
    Queue = queue:in({Root, 0}, queue:new()),
    width_of_binary_tree(Queue, 0).

width_of_binary_tree(Queue, MaxWidth) ->
    case queue:is_empty(Queue) of
        true -> MaxWidth;
        false ->
            {Size, NewQueue} = dequeue_level(Queue, queue:new(), 0, 0, 0),
            NewMaxWidth = max(MaxWidth, Size),
            width_of_binary_tree(NewQueue, NewMaxWidth)
    end.

dequeue_level(Queue, NewQueue, First, Last, Count) ->
    case queue:is_empty(Queue) of
        true -> {Last - First + 1, NewQueue};
        false ->
            {{value, {Node, Pos}}, RemQueue} = queue:out(Queue),
            NewCount = Count + 1,
            NewFirst = if NewCount == 1 -> Pos; true -> First end,
            NewLast = Pos,
            NewNewQueue = case Node#tree_node.left of
                null -> NewQueue;
                Left -> queue:in({Left, 2 * Pos}, NewQueue)
            end,
            NewNewQueue2 = case Node#tree_node.right of
                null -> NewNewQueue;
                Right -> queue:in({Right, 2 * Pos + 1}, NewNewQueue)
            end,
            dequeue_level(RemQueue, NewNewQueue2, NewFirst, NewLast, NewCount)
    end.