-spec min_add_to_make_valid(S :: unicode:unicode_binary()) -> integer().
min_add_to_make_valid(S) ->
    min_add_to_make_valid(S, 0, 0).

min_add_to_make_valid(<<>>, Open, Close) ->
    Open + Close;
min_add_to_make_valid(<<"a", Rest/binary>>, Open, Close) ->
    min_add_to_make_valid(Rest, Open + 1, Close);
min_add_to_make_valid(<<"b", Rest/binary>>, Open, Close) when Open > 0 ->
    min_add_to_make_valid(Rest, Open - 1, Close);
min_add_to_make_valid(<<"b", Rest/binary>>, Open, Close) ->
    min_add_to_make_valid(Rest, Open, Close + 1);
min_add_to_make_valid(<<"c", Rest/binary>>, Open, Close) when Open > 0, Close > 0 ->
    min_add_to_make_valid(Rest, Open - 1, Close - 1);
min_add_to_make_valid(<<"c", Rest/binary>>, Open, Close) when Open > 0 ->
    min_add_to_make_valid(Rest, Open - 1, Close + 1);
min_add_to_make_valid(<<"c", Rest/binary>>, Open, Close) when Close > 0 ->
    min_add_to_make_valid(Rest, Open + 1, Close - 1);
min_add_to_make_valid(<<"c", Rest/binary>>, Open, Close) ->
    min_add_to_make_valid(Rest, Open + 1, Close + 1).