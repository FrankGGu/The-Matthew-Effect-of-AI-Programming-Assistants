-spec is_good_array(Nums :: [integer()]) -> boolean().
is_good_array(Nums) ->
    GCD = fun
        GCD(0, B) -> B;
        GCD(A, B) -> GCD(B rem A, A)
    end,
    lists:foldl(fun(N, Acc) -> GCD(Acc, abs(N)) end, hd(Nums), tl(Nums)) == 1.