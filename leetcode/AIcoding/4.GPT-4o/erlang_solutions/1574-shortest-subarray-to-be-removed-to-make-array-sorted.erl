-module(solution).
-export([findUnsortedSubarray/1]).

findUnsortedSubarray(Array) ->
    Sorted = lists:sort(Array),
    {Start, End} = find_bounds(Array, Sorted, length(Array)),
    max(0, End - Start + 1).

find_bounds(Array, Sorted, N) ->
    find_start(Array, Sorted, N, 0, N - 1).

find_start(_, Sorted, N, Start, End) when Start < N, lists:nth(Start + 1, Array) == lists:nth(Start + 1, Sorted) ->
    find_start(Array, Sorted, N, Start + 1, End);
find_start(_, Sorted, N, Start, End) when End >= 0, lists:nth(End + 1, Array) == lists:nth(End + 1, Sorted) ->
    find_start(Array, Sorted, N, Start, End - 1);
find_start(_, _, _, Start, End) -> {Start, End}.