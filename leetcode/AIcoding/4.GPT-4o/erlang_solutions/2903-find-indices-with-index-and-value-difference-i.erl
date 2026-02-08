-module(solution).
-export([find_indices/2]).

find_indices(Nums, k) ->
    find_indices(Nums, k, 0, []).

find_indices([], _, _, Acc) ->
    lists:reverse(Acc);
find_indices([H | T], k, Index, Acc) ->
    case lists:member(Index + k, lists:seq(0, length(Nums) - 1)) of
        true ->
            find_indices(T, k, Index + 1, [Index | Acc]);
        false ->
            find_indices(T, k, Index + 1, Acc)
    end.