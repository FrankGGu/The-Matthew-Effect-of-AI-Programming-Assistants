-spec min_operations(Word :: unicode:unicode_binary()) -> integer().
min_operations(Word) ->
    min_operations(Word, 0, 1, 0).

min_operations(<<>>, _Prev, _I, Count) -> Count;
min_operations(<<C:8, Rest/binary>>, Prev, I, Count) when abs(C - Prev) =< 1, I > 1 ->
    min_operations(Rest, C + 1, I + 1, Count + 1);
min_operations(<<C:8, Rest/binary>>, _Prev, I, Count) ->
    min_operations(Rest, C, I + 1, Count).