-module(solution).
-export([min_operations/1]).

min_operations(Array) when is_list(Array) ->
    Sorted = lists:sort(Array),
    min_operations(Sorted, 0, 0).

min_operations([], Count, _) -> Count;
min_operations([H | T], Count, Prev) when H > Prev ->
    min_operations(T, Count + 1, H);
min_operations([H | T], Count, Prev) when H =< Prev ->
    min_operations(T, Count, Prev).