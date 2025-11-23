-module(solution).
-export([levelOrder/1]).

-record(tree_node, {val, left = nil, right = nil}).

queue_new() -> {[], []}.

queue_in(X, {H, T}) -> {H, [X|T]}.

queue_out({H, T}) ->
    case H of
        [] ->
            case lists:reverse(T) of
                [] -> {empty, {[], []}};
                [X|NewH] -> {value, X, {NewH, []}}
            end;
        [X|NewH] -> {value, X, {NewH, T}}
    end.

queue_is_empty({[], []}) -> true;
queue_is_empty(_) -> false.

levelOrder(Root) ->
    case Root of
        nil -> [];
        Node ->
            InitialQueue = queue_in(Node, queue_new()),
            bfs(InitialQueue, [])
    end.

bfs(Queue, AccLevels) ->
    case queue_is_empty(Queue) of
        true -> lists:reverse(AccLevels);
        false ->
            {CurrentLevelValuesReversed, NextQueue} = process_level(Queue, [], queue_new()),
            bfs(NextQueue, [lists:reverse(CurrentLevelValuesReversed) | AccLevels])
    end.

process_level(CurrentLevelQueue, AccCurrentLevelValuesReversed, AccNextLevelQueue) ->
    case queue_is_empty(CurrentLevelQueue) of
        true -> {AccCurrentLevelValuesReversed, AccNextLevelQueue};
        false ->
            {value, Node, RestCurrentLevelQueue} = queue_out(CurrentLevelQueue),
            #tree_node{val = Val, left = Left, right = Right} = Node,

            NewAccNextLevelQueue =
                case Left of
                    nil -> AccNextLevelQueue;
                    _ -> queue_in(Left, AccNextLevelQueue)
                end,
            NewAccNextLevelQueue2 =
                case Right of
                    nil -> NewAccNextLevelQueue;
                    _ -> queue_in(Right, NewAccNextLevelQueue)
                end,

            process_level(RestCurrentLevelQueue, [Val | AccCurrentLevelValuesReversed], NewAccNextLevelQueue2)
    end.