-module(solution).
-export([largest_values/1]).

largest_values(Root) ->
    case Root of
        nil -> [];
        _ ->
            Queue = queue:in(Root, queue:new()),
            find_max_values(Queue, [])
    end.

find_max_values(Queue, Acc) ->
    case queue:is_empty(Queue) of
        true -> lists:reverse(Acc);
        false ->
            {CurrentLevelMax, NextLevelQueue} = process_level(Queue, -2147483648, queue:new()),
            find_max_values(NextLevelQueue, [CurrentLevelMax | Acc])
    end.

process_level(CurrentLevelQueue, MaxValSoFar, NextLevelQueue) ->
    case queue:is_empty(CurrentLevelQueue) of
        true -> {MaxValSoFar, NextLevelQueue};
        false ->
            {{value, {Val, Left, Right}}, NewCurrentLevelQueue} = queue:out(CurrentLevelQueue),
            NewMaxValSoFar = max(MaxValSoFar, Val),
            NewNextLevelQueue = add_children_to_queue(NextLevelQueue, Left, Right),
            process_level(NewCurrentLevelQueue, NewMaxValSoFar, NewNextLevelQueue)
    end.

add_children_to_queue(Queue, nil, nil) -> Queue;
add_children_to_queue(Queue, Node, nil) -> queue:in(Node, Queue);
add_children_to_queue(Queue, nil, Node) -> queue:in(Node, Queue);
add_children_to_queue(Queue, Left, Right) -> queue:in(Right, queue:in(Left, Queue)).