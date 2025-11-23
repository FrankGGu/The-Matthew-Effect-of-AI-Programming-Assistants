-module(solution).
-export([count_possible_root_nodes/1]).

count_possible_root_nodes(Roots) ->
    count_possible_root_nodes(Roots, 0).

count_possible_root_nodes([], Count) ->
    Count;
count_possible_root_nodes([H | T], Count) ->
    NewCount = Count + (if H > 0 -> 1; true -> 0 end),
    count_possible_root_nodes(T, NewCount).