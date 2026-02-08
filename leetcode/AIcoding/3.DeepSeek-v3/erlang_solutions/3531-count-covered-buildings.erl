-spec count_buildings(Heights :: [integer()]) -> integer().
count_buildings(Heights) ->
    count_buildings(Heights, 0, -1).

count_buildings([], Count, _) -> Count;
count_buildings([H | T], Count, Max) when H > Max ->
    count_buildings(T, Count + 1, H);
count_buildings([_ | T], Count, Max) ->
    count_buildings(T, Count, Max).