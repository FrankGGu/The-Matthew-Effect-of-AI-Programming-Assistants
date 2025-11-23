-module(solution).
-export([kth_largest_level_sum/2]).

-record(treenode, {val, left, right}).

kth_largest_level_sum(Root, K) ->
    LevelSumsMap = bfs_and_sum(Root),
    SumsList = maps:values(LevelSumsMap),
    SortedSums = lists:sort(fun(A, B) -> A >= B end, SumsList),
    lists:nth(K, SortedSums).

bfs_and_sum(Root) ->
    Queue = queue:new(),
    Queue1 = queue:in({Root, 0}, Queue),
    bfs_and_sum_loop(Queue1, #{}).

bfs_and_sum_loop(Queue, AccLevelSums) ->
    case queue:out(Queue) of
        {{value, {nil, _}}, NewQueue} ->
            bfs_and_sum_loop(NewQueue, AccLevelSums);
        {{value, {Node, Level}}, NewQueue} ->
            Val = Node#treenode.val,
            Left = Node#treenode.left,
            Right = Node#treenode.right,

            CurrentSum = maps:get(Level, AccLevelSums, 0),
            NewAccLevelSums = maps:put(Level, CurrentSum + Val, AccLevelSums),

            QueueWithLeft = queue:in({Left, Level + 1}, NewQueue),
            QueueWithRight = queue:in({Right, Level + 1}, QueueWithLeft),
            bfs_and_sum_loop(QueueWithRight, NewAccLevelSums);
        {empty, _} ->
            AccLevelSums
    end.