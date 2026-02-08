-spec max_depth(S :: unicode:unicode_binary()) -> integer().
max_depth(S) ->
    max_depth(S, 0, 0).

max_depth(<<>>, _Current, Max) ->
    Max;
max_depth(<<"(", Rest/binary>>, Current, Max) ->
    NewCurrent = Current + 1,
    NewMax = max(NewCurrent, Max),
    max_depth(Rest, NewCurrent, NewMax);
max_depth(<<")", Rest/binary>>, Current, Max) ->
    max_depth(Rest, Current - 1, Max);
max_depth(<<_/utf8, Rest/binary>>, Current, Max) ->
    max_depth(Rest, Current, Max).