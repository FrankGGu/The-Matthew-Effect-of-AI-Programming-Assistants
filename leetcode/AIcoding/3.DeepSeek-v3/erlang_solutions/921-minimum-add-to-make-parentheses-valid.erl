-spec min_add_to_make_valid(S :: unicode:unicode_binary()) -> integer().
min_add_to_make_valid(S) ->
    min_add_to_make_valid(S, 0, 0).

min_add_to_make_valid(<<>>, Open, Close) ->
    Open + Close;
min_add_to_make_valid(<<"(", Rest/binary>>, Open, Close) ->
    min_add_to_make_valid(Rest, Open + 1, Close);
min_add_to_make_valid(<<")", Rest/binary>>, Open, Close) ->
    if
        Open > 0 -> min_add_to_make_valid(Rest, Open - 1, Close);
        true -> min_add_to_make_valid(Rest, Open, Close + 1)
    end.