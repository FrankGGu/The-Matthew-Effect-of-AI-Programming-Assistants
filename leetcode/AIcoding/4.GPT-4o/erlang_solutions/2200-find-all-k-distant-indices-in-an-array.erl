-module(solution).
-export([find_k_distant_indices/3]).

find_k_distant_indices(nums, key, k) ->
    KeyIndices = lists:filter(fun(Index) -> lists:nth(Index + 1, nums) =:= key end, lists:seq(0, length(nums) - 1)),
    DistantIndices = lists:flatmap(fun(Index) -> lists:seq(max(0, Index - k), min(length(nums) - 1, Index + k)) end, KeyIndices),
    lists:usort(DistantIndices).