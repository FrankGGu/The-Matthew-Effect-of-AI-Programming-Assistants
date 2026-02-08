-spec grid_game(Grid :: [[integer()]]) -> integer().
grid_game(Grid) ->
    [Row1, Row2] = Grid,
    N = length(Row1),
    Prefix1 = lists:foldl(fun(X, Acc) -> [hd(Acc) + X | Acc] end, [0], Row1),
    Prefix2 = lists:foldl(fun(X, Acc) -> [hd(Acc) + X | Acc] end, [0], Row2),
    Prefix1Rev = lists:reverse(Prefix1),
    Prefix2Rev = lists:reverse(Prefix2),
    lists:min([max(lists:nth(I, Prefix2Rev), lists:nth(N - I + 1, Prefix1Rev)) || I <- lists:seq(1, N)]).