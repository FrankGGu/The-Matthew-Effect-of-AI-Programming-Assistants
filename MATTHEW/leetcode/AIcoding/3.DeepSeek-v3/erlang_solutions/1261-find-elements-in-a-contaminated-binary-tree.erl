-spec find_elements_init_(Root :: #tree_node{} | null) -> any().
find_elements_init_(null) ->
    null;
find_elements_init_(Root) ->
    Set = sets:new(),
    Queue = queue:in({Root, 0}, queue:new()),
    {NewSet, _} = bfs(Queue, Set),
    NewSet.

bfs(Queue, Set) ->
    case queue:is_empty(Queue) of
        true -> {Set, Queue};
        false ->
            {{value, {Node, Val}}, NewQueue} = queue:out(Queue),
            NewSet = sets:add_element(Val, Set),
            NewQueue1 = case Node#tree_node.left of
                           null -> NewQueue;
                           Left -> queue:in({Left, 2 * Val + 1}, NewQueue)
                       end,
            NewQueue2 = case Node#tree_node.right of
                           null -> NewQueue1;
                           Right -> queue:in({Right, 2 * Val + 2}, NewQueue1)
                       end,
            bfs(NewQueue2, NewSet)
    end.

-spec find_elements_find(Target :: integer(), Set :: any()) -> boolean().
find_elements_find(Target, Set) ->
    sets:is_element(Target, Set).