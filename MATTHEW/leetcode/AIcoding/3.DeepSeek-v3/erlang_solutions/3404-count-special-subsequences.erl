-spec count_special_subsequences(Nums :: [integer()]) -> integer().
count_special_subsequences(Nums) ->
    {A, AB, ABC} = lists:foldl(fun
        (0, {A, AB, ABC}) -> {(A + A + 1) rem 1000000007, AB, ABC};
        (1, {A, AB, ABC}) -> {A, (AB + AB + A) rem 1000000007, ABC};
        (2, {A, AB, ABC}) -> {A, AB, (ABC + ABC + AB) rem 1000000007}
    end, {0, 0, 0}, Nums),
    ABC.