-module(delete_columns_to_make_sorted_ii).
-export([min_deletion_size/1]).

min_deletion_size(Rows) ->
    min_deletion_size(Rows, 0).

min_deletion_size([], Count) ->
    Count;
min_deletion_size([Row | Rest], Count) ->
    case is_sorted(Row, Rest) of
        true ->
            min_deletion_size(Rest, Count);
        false ->
            min_deletion_size(Rest, Count + 1)
    end.

is_sorted(_, []) ->
    true;
is_sorted([], _) ->
    true;
is_sorted([C | Cs], [NextRow | Rest]) ->
    case C < hd(NextRow) of
        true ->
            is_sorted(Cs, [NextRow | Rest]);
        false ->
            false
    end.