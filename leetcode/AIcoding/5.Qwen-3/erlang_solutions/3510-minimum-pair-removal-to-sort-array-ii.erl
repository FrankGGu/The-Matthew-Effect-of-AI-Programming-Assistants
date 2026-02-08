-module(min_pair_removal_to_sort_array_ii).
-export([min_pairs/1]).

min_pairs(Arr) ->
    min_pairs(Arr, 0, length(Arr) - 1, 0).

min_pairs([], _, _, Acc) ->
    Acc;
min_pairs([H | T], Left, Right, Acc) ->
    if
        H =< lists:nth(Left + 1, T) ->
            min_pairs(T, Left + 1, Right, Acc);
        true ->
            min_pairs(T, Left + 1, Right, Acc + 1)
    end.