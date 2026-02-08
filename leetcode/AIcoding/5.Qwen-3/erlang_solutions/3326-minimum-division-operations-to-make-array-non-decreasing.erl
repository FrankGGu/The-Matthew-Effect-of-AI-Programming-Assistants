-module(min_division_operations).
-export([min_operations/1]).

min_operations(A) ->
    min_operations(A, 0, length(A) - 1).

min_operations(_, _, 0) -> 0;
min_operations(A, Start, End) ->
    case is_non_decreasing(A, Start, End) of
        true -> 0;
        false ->
            Mid = (Start + End) div 2,
            Left = min_operations(A, Start, Mid),
            Right = min_operations(A, Mid + 1, End),
            Left + Right + 1
    end.

is_non_decreasing(_, _, 0) -> true;
is_non_decreasing(A, Start, End) ->
    is_non_decreasing(A, Start, End, 0).

is_non_decreasing(_, _, _, N) when N >= length(A) -> true;
is_non_decreasing(A, Start, End, N) ->
    if
        N == End -> true;
        true ->
            Current = lists:nth(Start + N + 1, A),
            Next = lists:nth(Start + N + 2, A),
            if
                Current > Next -> false;
                true -> is_non_decreasing(A, Start, End, N + 1)
            end
    end.