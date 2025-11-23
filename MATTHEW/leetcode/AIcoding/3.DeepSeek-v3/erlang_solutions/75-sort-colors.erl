-spec sort_colors(Nums :: [integer()]) -> [integer()].
sort_colors(Nums) ->
    Counts = lists:foldl(fun
        (0, {R, W, B}) -> {R + 1, W, B};
        (1, {R, W, B}) -> {R, W + 1, B};
        (2, {R, W, B}) -> {R, W, B + 1}
    end, {0, 0, 0}, Nums),
    {Red, White, Blue} = Counts,
    lists:duplicate(Red, 0) ++ lists:duplicate(White, 1) ++ lists:duplicate(Blue, 2).