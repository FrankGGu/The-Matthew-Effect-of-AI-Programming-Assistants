-module(solution).
-export([min_operations/1]).

min_operations(K) ->
    min_operations(K, 0, 0).

min_operations(K, Count, Sum) when Sum >= K ->
    Count;
min_operations(K, Count, Sum) ->
    Next = Count + 1,
    NewSum = Sum + Next,
    min_operations(K, Next, NewSum).