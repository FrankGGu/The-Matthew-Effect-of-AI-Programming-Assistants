-spec max_min_sum(Nums :: [integer()], K :: integer()) -> {integer(), integer()}.
max_min_sum(Nums, K) ->
    MaxSum = max_sum(Nums, K),
    MinSum = min_sum(Nums, K),
    {MaxSum, MinSum}.

max_sum(Nums, K) ->
    {Prefix, _} = lists:mapfoldl(fun(X, Sum) -> {Sum + X, Sum + X} end, 0, Nums),
    PrefixList = [0 | Prefix],
    Deque = array:new(),
    Max = -1000000000,
    {_, MaxSum} = lists:foldl(fun(I, {Q, CurrentMax}) ->
        while_not_empty_and_less(Q, I, K, PrefixList),
        Q1 = push_back(Q, I, PrefixList),
        CurrentMax1 = if
            I >= K -> max(CurrentMax, lists:nth(I + 1, PrefixList) - lists:nth(array:get(0, Q1) + 1, PrefixList));
            true -> CurrentMax
        end,
        {Q1, CurrentMax1}
    end, {Deque, Max}, lists:seq(0, length(Nums))),
    MaxSum.

min_sum(Nums, K) ->
    {Prefix, _} = lists:mapfoldl(fun(X, Sum) -> {Sum + X, Sum + X} end, 0, Nums),
    PrefixList = [0 | Prefix],
    Deque = array:new(),
    Min = 1000000000,
    {_, MinSum} = lists:foldl(fun(I, {Q, CurrentMin}) ->
        while_not_empty_and_greater(Q, I, K, PrefixList),
        Q1 = push_back(Q, I, PrefixList),
        CurrentMin1 = if
            I >= K -> min(CurrentMin, lists:nth(I + 1, PrefixList) - lists:nth(array:get(0, Q1) + 1, PrefixList));
            true -> CurrentMin
        end,
        {Q1, CurrentMin1}
    end, {Deque, Min}, lists:seq(0, length(Nums))),
    MinSum.

while_not_empty_and_less(Q, I, K, PrefixList) ->
    case array:size(Q) > 0 andalso array:get(0, Q) =< I - K of
        true -> while_not_empty_and_less(array:reset(0, Q), I, K, PrefixList);
        false -> ok
    end.

while_not_empty_and_greater(Q, I, K, PrefixList) ->
    case array:size(Q) > 0 andalso array:get(0, Q) =< I - K of
        true -> while_not_empty_and_greater(array:reset(0, Q), I, K, PrefixList);
        false -> ok
    end.

push_back(Q, I, PrefixList) ->
    case array:size(Q) > 0 andalso lists:nth(array:get(array:size(Q) - 1, Q) + 1, PrefixList) >= lists:nth(I + 1, PrefixList) of
        true -> push_back(array:reset(array:size(Q) - 1, Q), I, PrefixList);
        false -> array:set(array:size(Q), I, Q)
    end.