-module(delete_columns_to_make_sorted).
-export([min_deletion_effort/1]).

min_deletion_effort(Rows) ->
    min_deletion_effort(Rows, 0).

min_deletion_effort([], Acc) ->
    Acc;
min_deletion_effort([Row | Rest], Acc) ->
    case is_sorted(Row) of
        true ->
            min_deletion_effort(Rest, Acc);
        false ->
            min_deletion_effort(Rest, Acc + 1)
    end.

is_sorted([]) ->
    true;
is_sorted([_]) ->
    true;
is_sorted([A, B | Rest]) ->
    if
        A =< B ->
            is_sorted([B | Rest]);
        true ->
            false
    end.