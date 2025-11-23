-spec max_altitude(Gain :: [integer()]) -> integer().
max_altitude(Gain) ->
    lists:max(altitudes(Gain, 0, [0])).

altitudes([], _, Acc) -> lists:reverse(Acc);
altitudes([H|T], Current, Acc) ->
    NewCurrent = Current + H,
    altitudes(T, NewCurrent, [NewCurrent|Acc]).