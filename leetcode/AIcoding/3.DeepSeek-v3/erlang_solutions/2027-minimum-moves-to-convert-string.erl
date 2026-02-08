-spec minimum_moves(S :: unicode:unicode_binary()) -> integer().
minimum_moves(S) ->
    minimum_moves(S, 0).

minimum_moves(<<>>, Count) ->
    Count;
minimum_moves(<<$X, Rest/binary>>, Count) ->
    minimum_moves(Rest, Count);
minimum_moves(<<$O, _/binary>>, Count) ->
    Count;
minimum_moves(<<_, _, _, Rest/binary>>, Count) ->
    minimum_moves(Rest, Count + 1).