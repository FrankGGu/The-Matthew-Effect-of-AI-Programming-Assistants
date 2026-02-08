-module(solution).
-export([kth_smallest/2]).

kth_smallest(Denominations, K) ->
    Sorted = lists:sort(Denominations),
    N = length(Sorted),
    find_kth(Sorted, K, N).

find_kth(Denominations, K, N) ->
    find_kth_helper(Denominations, K, N, 0, 0).

find_kth_helper(_, K, N, CurrentSum, _) when CurrentSum >= K ->
    CurrentSum;

find_kth_helper(Denominations, K, N, CurrentSum, Index) ->
    case Index of
        N -> -1;
        _ -> 
            NextSum = CurrentSum + lists:nth(Index + 1, Denominations),
            find_kth_helper(Denominations, K, N, NextSum, Index + 1)
    end.