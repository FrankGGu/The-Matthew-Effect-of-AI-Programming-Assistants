-spec max_sum_div_three(Nums :: [integer()]) -> integer().
max_sum_div_three(Nums) ->
    DP = [0, -100000, -100000],
    lists:foldl(fun(Num, [A, B, C]) ->
        case Num rem 3 of
            0 -> [A + Num, B + Num, C + Num];
            1 -> [max(A, C + Num), max(B, A + Num), max(C, B + Num)];
            2 -> [max(A, B + Num), max(B, C + Num), max(C, A + Num)]
        end
    end, DP, Nums),
    hd(DP).