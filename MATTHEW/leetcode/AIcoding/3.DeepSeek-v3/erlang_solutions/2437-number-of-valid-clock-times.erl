-spec count_time(Time :: unicode:unicode_binary()) -> integer().
count_time(Time) ->
    [H1, H2, $:, M1, M2] = unicode:characters_to_list(Time),
    count_hours(H1, H2) * count_minutes(M1, M2).

count_hours($?, $?) -> 24;
count_hours($?, H2) when H2 >= $4 -> 2;
count_hours($?, _) -> 3;
count_hours(H1, $?) when H1 == $2 -> 4;
count_hours(H1, $?) when H1 < $2 -> 10;
count_hours(_, $?) -> 6;
count_hours(H1, H2) -> 1.

count_minutes($?, $?) -> 60;
count_minutes($?, M2) -> 6;
count_minutes(M1, $?) -> 10;
count_minutes(_, _) -> 1.