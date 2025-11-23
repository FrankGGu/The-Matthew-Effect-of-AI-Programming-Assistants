-module(solution).
-export([partitionArray/2]).

partitionArray(Nums, K) ->
    SortedNums = lists:sort(Nums),
    partition_recursive(tl(SortedNums), K, 1, hd(SortedNums)).

partition_recursive([], _K, Count, _CurrentMin) ->
    Count;
partition_recursive([H|T], K, Count, CurrentMin) ->
    if
        H - CurrentMin > K ->
            partition_recursive(T, K, Count + 1, H);
        true ->
            partition_recursive(T, K, Count, CurrentMin)
    end.