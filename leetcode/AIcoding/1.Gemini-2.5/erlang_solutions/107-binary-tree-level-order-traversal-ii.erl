-module(solution).
-export([levelOrderBottom/1]).

-record(treenode, {val, left, right}).

levelOrderBottom(Root) ->
    case Root of
        null ->
            [];
        _ ->
            InitialQueue = queue:in(Root, queue:new()),
            bfs(InitialQueue, [])
    end.

bfs(Queue, AccLevels) ->
    case queue:is_empty(Queue) of
        true ->
            AccLevels;
        false ->
            {CurrentLevelNodes, NextQueue} = process_level(Queue, [], queue:new()),
            bfs(NextQueue, [CurrentLevelNodes | AccLevels])
    end.

process_level(CurrentQueue, CurrentLevelValuesAcc, NextQueueAcc) ->
    case queue:is_empty(CurrentQueue) of
        true ->
            {lists:reverse(CurrentLevelValuesAcc), NextQueueAcc};
        false ->
            {value, #treenode{val = Val, left = Left, right = Right}, RemainingQueue} = queue:out(CurrentQueue),

            NewNextQueueAcc =
                case Left of
                    null -> NextQueueAcc;
                    _ -> queue:in(Left, NextQueueAcc)
                end,
            NewNextQueueAcc2 =
                case Right of
                    null -> NewNextQueueAcc;
                    _ -> queue:in(Right, NewNextQueueAcc)
                end,

            process_level(RemainingQueue, [Val | CurrentLevelValuesAcc], NewNextQueueAcc2)
    end.