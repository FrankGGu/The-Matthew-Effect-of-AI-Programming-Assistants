-spec max_power(S :: unicode:unicode_binary()) -> integer().
max_power(S) ->
    max_power(S, 1, 1, 1).

max_power(<<>>, _, _, Max) -> Max;
max_power(<<C, Rest/binary>>, Prev, Current, Max) when C =:= Prev ->
    NewCurrent = Current + 1,
    NewMax = max(NewCurrent, Max),
    max_power(Rest, C, NewCurrent, NewMax);
max_power(<<C, Rest/binary>>, _, _, Max) ->
    max_power(Rest, C, 1, Max).