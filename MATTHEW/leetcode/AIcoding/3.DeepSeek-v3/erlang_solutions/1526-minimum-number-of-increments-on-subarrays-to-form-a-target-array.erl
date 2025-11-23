-spec min_number_operations(Target :: [integer()]) -> integer().
min_number_operations(Target) ->
    min_number_operations(Target, 0, 0).

min_number_operations([], _, Res) -> Res;
min_number_operations([H | T], Prev, Res) ->
    if
        H > Prev -> min_number_operations(T, H, Res + H - Prev);
        true -> min_number_operations(T, H, Res)
    end.