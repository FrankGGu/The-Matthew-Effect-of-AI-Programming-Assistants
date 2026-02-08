-spec count_special_subsequences(Nums :: [integer()]) -> integer().
count_special_subsequences(Nums) ->
    {A, B, C} = lists:foldl(fun
        (0, {A, B, C}) -> {(A * 2 + 1) rem 1000000007, B, C};
        (1, {A, B, C}) -> {A, (B * 2 + A) rem 1000000007, C};
        (2, {A, B, C}) -> {A, B, (C * 2 + B) rem 1000000007}
    end, {0, 0, 0}, Nums),
    C.