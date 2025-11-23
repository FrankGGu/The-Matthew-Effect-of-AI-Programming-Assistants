-module(solution).
-export([max_chunks_to_sorted/1]).

max_chunks_to_sorted(Arr) ->
    N = length(Arr),
    Max = lists:max(Arr),
    Min = lists:min(Arr),
    Count = count_chunks(Arr, 0, 0, Max, Min),
    Count.

count_chunks([], _, Count, _, _) -> Count;
count_chunks([H | T], MaxSeen, Count, Max, Min) ->
    NewMaxSeen = max(MaxSeen, H),
    NewCount = if NewMaxSeen == Max -> Count + 1; true -> Count end,
    count_chunks(T, NewMaxSeen, NewCount, Max, Min).