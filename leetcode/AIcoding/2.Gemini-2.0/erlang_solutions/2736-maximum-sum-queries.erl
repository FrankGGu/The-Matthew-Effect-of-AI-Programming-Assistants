-module(maximum_sum_queries).
-export([maximum_sum_queries/3]).

maximum_sum_queries(Nums1, Nums2, Queries) ->
    Sorted = lists:keysort(1, lists:zip(Nums1, Nums2)),
    solve(Sorted, Queries).

solve(Sorted, Queries) ->
    Acc = [],
    lists:foldl(fun(Query, AccIn) ->
        process_query(Sorted, Query, AccIn)
    end, [], Queries).

process_query(Sorted, {X, Y}, Acc) ->
    MaxSum = find_max_sum(Sorted, X, Y),
    [MaxSum | Acc].

find_max_sum(Sorted, X, Y) ->
    find_max_sum_helper(Sorted, X, Y, -1).

find_max_sum_helper([], _X, _Y, MaxSum) ->
    MaxSum;
find_max_sum_helper([{Num1, Num2} | Rest], X, Y, MaxSum) ->
    if Num1 >= X andalso Num2 >= Y then
        NewMaxSum = max(MaxSum, Num1 + Num2),
        find_max_sum_helper(Rest, X, Y, NewMaxSum)
    else
        find_max_sum_helper(Rest, X, Y, MaxSum)
    end.