-module(solution).
-export([find_x_sum/2]).

find_x_sum(Nums, K) ->
    find_x_sum_recursive(Nums, K, []).

find_x_sum_recursive(Nums, K, Acc) when length(Nums) < K ->
    lists:reverse(Acc);
find_x_sum_recursive(Nums, K, Acc) ->
    CurrentWindow = lists:sublist(Nums, K),
    WindowSum = lists:sum(CurrentWindow),
    find_x_sum_recursive(tl(Nums), K, [WindowSum | Acc]).