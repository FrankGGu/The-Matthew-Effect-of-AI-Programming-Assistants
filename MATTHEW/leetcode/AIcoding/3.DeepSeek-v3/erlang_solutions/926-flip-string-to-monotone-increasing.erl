-spec min_flips_mono_incr(S :: unicode:unicode_binary()) -> integer().
min_flips_mono_incr(S) ->
    Bin = unicode:characters_to_binary(S),
    min_flips_mono_incr(Bin, 0, 0).

min_flips_mono_incr(<<>>, Flips, Ones) ->
    Flips;
min_flips_mono_incr(<<"0", Rest/binary>>, Flips, Ones) ->
    min_flips_mono_incr(Rest, min(Flips + 1, Ones), Ones);
min_flips_mono_incr(<<"1", Rest/binary>>, Flips, Ones) ->
    min_flips_mono_incr(Rest, Flips, Ones + 1).