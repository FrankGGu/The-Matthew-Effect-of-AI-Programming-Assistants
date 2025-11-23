-module(solution).
-export([target_indices/2]).

target_indices(Nums, Target) ->
    Sorted = lists:sort(Nums),
    find_indices(Sorted, Target, 0, []).

find_indices([], _, _, Acc) ->
    lists:reverse(Acc);
find_indices([H | T], Target, Index, Acc) when H == Target ->
    find_indices(T, Target, Index + 1, [Index | Acc]);
find_indices([_ | T], Target, Index, Acc) ->
    find_indices(T, Target, Index + 1, Acc).