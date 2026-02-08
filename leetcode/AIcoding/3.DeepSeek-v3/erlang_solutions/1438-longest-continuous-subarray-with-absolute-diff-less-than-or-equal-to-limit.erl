-spec longest_subarray(Nums :: [integer()], Limit :: integer()) -> integer().
longest_subarray(Nums, Limit) ->
    {MaxQueue, MinQueue} = {queue:new(), queue:new()},
    {Left, Right, MaxLen} = {0, 0, 0},
    longest_subarray(Nums, Limit, Left, Right, MaxLen, MaxQueue, MinQueue).

longest_subarray([], _Limit, _Left, _Right, MaxLen, _MaxQueue, _MinQueue) ->
    MaxLen;
longest_subarray([Num | Rest], Limit, Left, Right, MaxLen, MaxQueue, MinQueue) ->
    {NewMaxQueue, NewMinQueue} = update_queues(Num, MaxQueue, MinQueue),
    case is_valid(NewMaxQueue, NewMinQueue, Limit) of
        true ->
            NewMaxLen = max(MaxLen, Right - Left + 1),
            longest_subarray(Rest, Limit, Left, Right + 1, NewMaxLen, NewMaxQueue, NewMinQueue);
        false ->
            {NewLeft, NewMaxQueue2, NewMinQueue2} = adjust_queues(Nums, Left, NewMaxQueue, NewMinQueue, Limit),
            longest_subarray(Rest, Limit, NewLeft, Right + 1, MaxLen, NewMaxQueue2, NewMinQueue2)
    end.

update_queues(Num, MaxQueue, MinQueue) ->
    NewMaxQueue = queue:filter(fun(X) -> X >= Num end, MaxQueue),
    NewMinQueue = queue:filter(fun(X) -> X =< Num end, MinQueue),
    {queue:in(Num, NewMaxQueue), queue:in(Num, NewMinQueue)}.

is_valid(MaxQueue, MinQueue, Limit) ->
    case {queue:is_empty(MaxQueue), queue:is_empty(MinQueue)} of
        {true, true} -> true;
        _ ->
            Max = queue:head(MaxQueue),
            Min = queue:head(MinQueue),
            Max - Min =< Limit
    end.

adjust_queues(Nums, Left, MaxQueue, MinQueue, Limit) ->
    case is_valid(MaxQueue, MinQueue, Limit) of
        true -> {Left, MaxQueue, MinQueue};
        false ->
            Num = lists:nth(Left + 1, Nums),
            NewMaxQueue = case queue:head(MaxQueue) == Num of
                              true -> queue:drop(MaxQueue);
                              false -> MaxQueue
                          end,
            NewMinQueue = case queue:head(MinQueue) == Num of
                              true -> queue:drop(MinQueue);
                              false -> MinQueue
                          end,
            adjust_queues(Nums, Left + 1, NewMaxQueue, NewMinQueue, Limit)
    end.