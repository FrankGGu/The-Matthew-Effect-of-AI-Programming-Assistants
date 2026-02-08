-module(solution).
-export([levelOrder/1]).

levelOrder(null) ->
    [];
levelOrder(Root) ->
    Queue = queue:in(Root, queue:new()),
    bfs(Queue, []).

bfs(Queue, Acc) ->
    case queue:is_empty(Queue) of
        true -> lists:reverse(Acc);
        false ->
            {CurrentLevelNodes, NextQueue} = process_level(Queue, [], queue:len(Queue), queue:new()),
            bfs(NextQueue, [CurrentLevelNodes | Acc])
    end.

process_level(CurrentQueue, CurrentLevelNodesAcc, 0, NextQueueAcc) ->
    {lists:reverse(CurrentLevelNodesAcc), NextQueueAcc};
process_level(CurrentQueue, CurrentLevelNodesAcc, Count, NextQueueAcc) ->
    {value, Node} = queue:head(CurrentQueue),
    NewCurrentQueue = queue:tail(CurrentQueue),

    Val = maps:get(val, Node),
    Children = maps:get(children, Node),

    NewNextQueueAcc = lists:foldl(
        fun(Child, Acc) ->
            queue:in(Child, Acc)
        end,
        NextQueueAcc,
        Children
    ),

    process_level(NewCurrentQueue, [Val | CurrentLevelNodesAcc], Count - 1, NewNextQueueAcc).