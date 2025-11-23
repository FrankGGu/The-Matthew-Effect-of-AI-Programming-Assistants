-module(kth_largest_sum).
-export([kthLargestSum/2]).

kthLargestSum(Root, K) ->
    SumList = bfs(Root),
    Sorted = lists:reverse(lists:sort(SumList)),
    lists:nth(K, Sorted).

bfs(nil) ->
    [];
bfs(Root) ->
    Queue = queue:from_list([Root]),
    SumList = [],
    bfs(Queue, SumList).

bfs(Queue, SumList) ->
    case queue:out(Queue) of
        {empty, _} ->
            SumList;
        { {value, Node}, NewQueue } ->
            {Left, Right} = Node,
            CurrentSum = node_value(Node),
            NewSumList = [CurrentSum | SumList],
            NewQueue1 = queue:in(Left, NewQueue),
            NewQueue2 = queue:in(Right, NewQueue1),
            bfs(NewQueue2, NewSumList)
    end.

node_value({Val, _, _}) ->
    Val.