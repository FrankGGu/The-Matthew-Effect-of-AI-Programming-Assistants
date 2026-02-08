-module(min_pair_removal_to_sort_array_i).
-export([min_removals/1]).

min_removals(List) ->
    min_removals(List, 0, 0).

min_removals([], _Count, _Last) ->
    0;
min_removals([H | T], Count, Last) when H >= Last ->
    min_removals(T, Count, H);
min_removals([H | T], Count, Last) ->
    min_removals(T, Count + 1, Last).