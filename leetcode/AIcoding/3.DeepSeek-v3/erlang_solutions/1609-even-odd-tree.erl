-spec is_even_odd_tree(Root :: #tree_node{} | null) -> boolean().
is_even_odd_tree(null) -> false;
is_even_odd_tree(Root) ->
    Queue = queue:in(Root, queue:new()),
    Level = 0,
    check_level(Queue, Level).

check_level(Queue, Level) ->
    case queue:is_empty(Queue) of
        true -> true;
        false ->
            {NewQueue, PrevVal, Valid} = process_level(Queue, Level, queue:new(), none, true),
            case Valid of
                false -> false;
                true -> check_level(NewQueue, Level + 1)
            end
    end.

process_level(Queue, Level, NewQueue, PrevVal, Valid) ->
    case queue:out(Queue) of
        {empty, _} -> {NewQueue, PrevVal, Valid};
        {{value, Node}, RestQueue} ->
            Val = Node#tree_node.val,
            NewValid = check_valid(Val, PrevVal, Level) andalso Valid,
            NewPrevVal = Val,
            UpdatedQueue = add_children(Node, NewQueue),
            process_level(RestQueue, Level, UpdatedQueue, NewPrevVal, NewValid)
    end.

check_valid(Val, none, Level) ->
    case Level rem 2 of
        0 -> Val rem 2 =:= 1;
        1 -> Val rem 2 =:= 0
    end;
check_valid(Val, PrevVal, Level) ->
    case Level rem 2 of
        0 -> (Val rem 2 =:= 1) andalso (Val > PrevVal);
        1 -> (Val rem 2 =:= 0) andalso (Val < PrevVal)
    end.

add_children(Node, Queue) ->
    Left = Node#tree_node.left,
    Right = Node#tree_node.right,
    Queue1 = case Left of
                null -> Queue;
                _ -> queue:in(Left, Queue)
             end,
    Queue2 = case Right of
                null -> Queue1;
                _ -> queue:in(Right, Queue1)
             end,
    Queue2.