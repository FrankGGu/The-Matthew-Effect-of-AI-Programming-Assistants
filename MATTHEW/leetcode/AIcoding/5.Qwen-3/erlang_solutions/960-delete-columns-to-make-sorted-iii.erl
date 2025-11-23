-module(delete_columns_to_make_sorted_iii).
-export([min_deletion_size/1]).

min_deletion_size(Rows) ->
    min_deletion_size(Rows, 0).

min_deletion_size([], _) ->
    0;
min_deletion_size([Row | Rest], Count) ->
    case is_sorted(Row, Rest) of
        true ->
            min_deletion_size(Rest, Count + 1);
        false ->
            min_deletion_size(Rest, Count)
    end.

is_sorted(_, []) ->
    true;
is_sorted([C | Cs], [NextRow | Rest]) ->
    case lists:all(fun (R) -> hd(R) >= C end, [NextRow | Rest]) of
        true ->
            is_sorted(Cs, [tl(NextRow) | Rest]);
        false ->
            false
    end.