-module(solution).
-export([is_sorted_and_rotated/1]).

is_sorted_and_rotated(A) ->
    is_sorted_and_rotated(A, 0).

is_sorted_and_rotated([], _) ->
    true;
is_sorted_and_rotated([H | T], Count) when Count >= 2 ->
    false;
is_sorted_and_rotated([H | T], Count) ->
    case T of
        [] ->
            true;
        [N | _] when H > N ->
            is_sorted_and_rotated(T, Count + 1);
        _ ->
            is_sorted_and_rotated(T, Count)
    end.