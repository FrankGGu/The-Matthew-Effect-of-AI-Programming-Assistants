-spec min_flips(Target :: unicode:unicode_binary()) -> integer().
min_flips(Target) ->
    min_flips(Target, $0, 0).

min_flips(<<>>, _, Flips) ->
    Flips;
min_flips(<<C:8, Rest/binary>>, Current, Flips) ->
    if
        C =/= Current ->
            min_flips(Rest, C, Flips + 1);
        true ->
            min_flips(Rest, Current, Flips)
    end.