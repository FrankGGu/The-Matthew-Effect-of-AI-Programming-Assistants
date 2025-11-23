-spec max_kelements(Nums :: [integer()], K :: integer()) -> integer().
max_kelements(Nums, K) ->
    PriorityQueue = lists:foldl(
        fun(Num, Q) -> 
            heap:insert(Q, -Num) 
        end, 
        heap:new(), 
        Nums
    ),
    max_kelements(PriorityQueue, K, 0).

max_kelements(_PriorityQueue, 0, Sum) -> Sum;
max_kelements(PriorityQueue, K, Sum) ->
    {Max, Q1} = heap:extract(PriorityQueue),
    Current = -Max,
    NewSum = Sum + Current,
    NewNum = Current div 3,
    Q2 = heap:insert(Q1, -NewNum),
    max_kelements(Q2, K - 1, NewSum).