-module(solution).
-export([find_max_average/2]).

find_max_average(Nums, K) ->
    List = Nums,
    Len = length(List),
    Sum = lists:foldl(fun(X, Acc) -> X + Acc end, 0, lists:sublist(List, K)),
    MaxSum = find_max_sum(List, K, Sum, Sum, 1),
    MaxSum / K.

find_max_sum(_, _, MaxSum, CurrentSum, I) when I > length(lists:sublist(lists:reverse(lists:tl(lists:reverse(lists:sublist(lists:reverse(List), 1, length(List) - K + 1)))), 1)) ->
    MaxSum;
find_max_sum(List, K, MaxSum, CurrentSum, I) ->
    NextI = I + 1,
    NextSum = CurrentSum - lists:nth(I, List) + lists:nth(I + K - 1, List),
    NewMaxSum = max(MaxSum, NextSum),
    find_max_sum(List, K, NewMaxSum, NextSum, NextI).