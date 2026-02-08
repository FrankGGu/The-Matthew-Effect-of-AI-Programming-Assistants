-spec subarray_gcd(Nums :: [integer()], K :: integer()) -> integer().
subarray_gcd(Nums, K) ->
    Count = 0,
    Length = length(Nums),
    lists:foldl(
        fun(I, Acc) ->
            CurrentGcd = 0,
            lists:foldl(
                fun(J, {Cnt, Gcd}) ->
                    NewGcd = case Gcd of
                        0 -> lists:nth(J, Nums);
                        _ -> gcd(Gcd, lists:nth(J, Nums))
                    end,
                    case NewGcd of
                        K -> {Cnt + 1, NewGcd};
                        _ -> {Cnt, NewGcd}
                    end
                end,
                {Acc, 0},
                lists:seq(I, Length)
            )
        end,
        Count,
        lists:seq(1, Length)
    ).

gcd(A, 0) -> A;
gcd(A, B) -> gcd(B, A rem B).