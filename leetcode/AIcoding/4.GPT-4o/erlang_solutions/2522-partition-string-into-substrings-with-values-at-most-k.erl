-module(solution).
-export([partition_string/2]).

partition_string(S, K) ->
    partition_string(S, K, 0, 0).

partition_string([], _, Count, _) ->
    Count;
partition_string([H | T], K, Count, Current) when Current + (H - $0) =< K ->
    partition_string(T, K, Count, Current + (H - $0));
partition_string([H | T], K, Count, Current) ->
    partition_string(T, K, Count + 1, (H - $0)).