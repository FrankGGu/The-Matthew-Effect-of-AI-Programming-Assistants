-module(solution).
-export([find_least_num_of_unique_ints/2]).

find_least_num_of_unique_ints(Arr, K) ->
    FreqMap = lists:foldl(fun(N, Acc) -> maps:update_with(N, fun(V) -> V + 1 end, 1, Acc) end, #{}, Arr),

    FreqValues = maps:values(FreqMap),
    SortedFreqs = lists:sort(FreqValues),

    InitialUniqueCount = maps:size(FreqMap),

    remove_freqs(SortedFreqs, K, InitialUniqueCount).

remove_freqs([], _K, UniqueCount) ->
    UniqueCount;
remove_freqs([F | Rest], K, UniqueCount) when K >= F ->
    remove_freqs(Rest, K - F, UniqueCount - 1);
remove_freqs([_F | _Rest], _K, UniqueCount) ->
    UniqueCount.