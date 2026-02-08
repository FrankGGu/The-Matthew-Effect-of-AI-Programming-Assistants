-spec count_asterisks(S :: unicode:unicode_binary()) -> integer().
count_asterisks(S) ->
    count_asterisks(S, 0, true).

count_asterisks(<<>>, Count, _) ->
    Count;
count_asterisks(<<"|", Rest/binary>>, Count, InsidePair) ->
    count_asterisks(Rest, Count, not InsidePair);
count_asterisks(<<"*", Rest/binary>>, Count, true) ->
    count_asterisks(Rest, Count + 1, true);
count_asterisks(<<_/utf8, Rest/binary>>, Count, InsidePair) ->
    count_asterisks(Rest, Count, InsidePair).