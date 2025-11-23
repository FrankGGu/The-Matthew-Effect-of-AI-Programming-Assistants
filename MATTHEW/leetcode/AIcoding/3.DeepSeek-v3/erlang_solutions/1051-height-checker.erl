-spec height_checker(Heights :: [integer()]) -> integer().
height_checker(Heights) ->
    Sorted = lists:sort(Heights),
    lists:foldl(fun({H, S}, Acc) -> if H =/= S -> Acc + 1; true -> Acc end end, 0, lists:zip(Heights, Sorted)).