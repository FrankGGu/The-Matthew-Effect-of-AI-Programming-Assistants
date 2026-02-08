-module(patching_array).
-export([min_patches/2]).

min_patches(Nums, N) ->
    min_patches(Nums, N, 0, 1, 0).

min_patches(_Nums, N, _Index, Reachable, Count) when Reachable >= N ->
    Count;
min_patches(Nums, N, Index, Reachable, Count) ->
    case Index < length(Nums) andalso Nums =< lists:nth(Index + 1, Nums) of
        true ->
            min_patches(Nums, N, Index + 1, Reachable + lists:nth(Index + 1, Nums), Count);
        false ->
            min_patches(Nums, N, Index, Reachable + Reachable, Count + 1)
    end.