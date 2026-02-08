-module(solution).
-export([ways_to_partition/2]).

ways_to_partition(Nums, K) ->
    Sum = lists:sum(Nums),
    Prefix = prefix_sum(Nums),
    Suffix = sufix_sum(Nums),
    Left = maps:new(),
    Right = maps:new(),
    lists:foldl(fun(X, Acc) -> maps:update_with(X, fun(V) -> V + 1 end, 1, Acc) end, Right, tl(Suffix)),
    Count = case maps:get(Sum - 2 * K, Right, 0) of
                0 -> 0;
                V -> V
            end,
    lists:foldl(fun(I, {Max, L, R}) ->
                    L1 = maps:update_with(lists:nth(I, Prefix), fun(V) -> V + 1 end, 1, L),
                    R1 = maps:update_with(lists:nth(I + 1, Suffix), fun(V) -> V - 1 end, R),
                    NewSum = Sum - lists:nth(I, Nums) + K,
                    NewCount = case maps:get(NewSum - 2 * K, L1, 0) + maps:get(NewSum - 2 * K, R1, 0) of
                                  0 -> 0;
                                  V -> V
                              end,
                    {max(Max, NewCount), L1, R1}
                end, {Count, Left, Right}, lists:seq(1, length(Nums) - 1)),
    element(1, lists:foldl(fun(I, {Max, L, R}) ->
                    L1 = maps:update_with(lists:nth(I, Prefix), fun(V) -> V + 1 end, 1, L),
                    R1 = maps:update_with(lists:nth(I + 1, Suffix), fun(V) -> V - 1 end, R),
                    NewSum = Sum - lists:nth(I, Nums) + K,
                    NewCount = case maps:get(NewSum - 2 * K, L1, 0) + maps:get(NewSum - 2 * K, R1, 0) of
                                  0 -> 0;
                                  V -> V
                              end,
                    {max(Max, NewCount), L1, R1}
                end, {Count, Left, Right}, lists:seq(1, length(Nums) - 1))).

prefix_sum(Nums) ->
    lists:reverse(lists:foldl(fun(X, Acc) -> [X + hd(Acc) | Acc] end, [0], Nums)).

sufix_sum(Nums) ->
    lists:reverse(lists:foldl(fun(X, Acc) -> [X + hd(Acc) | Acc] end, [0], lists:reverse(Nums))).