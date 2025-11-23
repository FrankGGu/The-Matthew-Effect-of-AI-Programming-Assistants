-spec min_time_to_type(Word :: unicode:unicode_binary()) -> integer().
min_time_to_type(Word) ->
    min_time_to_type(Word, $a, 0).

min_time_to_type(<<>>, _Current, Time) ->
    Time;
min_time_to_type(<<C, Rest/binary>>, Current, Time) ->
    Diff = abs(C - Current),
    MoveTime = min(Diff, 26 - Diff),
    min_time_to_type(Rest, C, Time + MoveTime + 1).