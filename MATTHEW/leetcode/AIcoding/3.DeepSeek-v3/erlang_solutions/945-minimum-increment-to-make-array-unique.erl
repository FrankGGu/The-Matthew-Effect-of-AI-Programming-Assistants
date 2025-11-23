-spec min_increment_for_unique(Nums :: [integer()]) -> integer().
min_increment_for_unique(Nums) ->
    Sorted = lists:sort(Nums),
    min_increment_for_unique(Sorted, 0, 0).

min_increment_for_unique([], _Prev, Moves) ->
    Moves;
min_increment_for_unique([H | T], Prev, Moves) when H > Prev ->
    min_increment_for_unique(T, H, Moves);
min_increment_for_unique([H | T], Prev, Moves) ->
    Needed = Prev + 1,
    min_increment_for_unique(T, Needed, Moves + (Needed - H)).