-module(solution).
-export([count_complete_subarrays/1]).

count_complete_subarrays(Array) ->
    N = length(Array),
    UniqueCount = array:from_list(lists:usort(Array)),
    UniqueSize = tuple_size(UniqueCount),
    count_subarrays(Array, UniqueSize, N, 0, 0).

count_subarrays(_, UniqueSize, N, Left, Count) when Left >= N ->
    Count;
count_subarrays(Array, UniqueSize, N, Left, Count) ->
    NewCount = case is_complete_subarray(Array, Left, UniqueSize) of
        true -> Count + 1;
        false -> Count
    end,
    count_subarrays(Array, UniqueSize, N, Left + 1, NewCount).

is_complete_subarray(Array, Left, UniqueSize) ->
    SubArray = lists:sublist(Array, Left, length(Array) - Left + 1),
    UniqueElements = length(lists:usort(SubArray)),
    UniqueElements =:= UniqueSize.