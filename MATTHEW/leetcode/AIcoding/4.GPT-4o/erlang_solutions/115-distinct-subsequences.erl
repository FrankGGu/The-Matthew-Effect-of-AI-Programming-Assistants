-spec num_distinct(S :: unicode:unicode_binary(), T :: unicode:unicode_binary()) -> integer().
num_distinct(S, T) ->
    num_distinct(S, T, length(S), length(T)).

num_distinct(_, _, 0, _) -> 1;
num_distinct(_, _, _, 0) -> 0;
num_distinct([], _, _, _) -> 0;
num_distinct([SHead | STail], [THead | TTail], LenS, LenT) when SHead =:= THead ->
    num_distinct(STail, TTail, LenS - 1, LenT - 1) + num_distinct(STail, [THead | TTail], LenS - 1, LenT);
num_distinct([_ | STail], [THead | TTail], LenS, LenT) ->
    num_distinct(STail, [THead | TTail], LenS - 1, LenT).
