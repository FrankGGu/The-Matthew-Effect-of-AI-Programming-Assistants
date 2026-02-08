-module(solution).
-export([target_indices/2]).

target_indices(Arr, target) ->
    Sorted = lists:sort(Arr),
    find_indices(Sorted, target, 0, []).

find_indices([], _, _, Acc) ->
    lists:reverse(Acc);
find_indices([H | T], Target, Index, Acc) ->
    if
        H == Target ->
            find_indices(T, Target, Index + 1, [Index | Acc]);
        true ->
            find_indices(T, Target, Index + 1, Acc)
    end.