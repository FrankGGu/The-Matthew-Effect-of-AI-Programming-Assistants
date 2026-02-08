-spec single_number(Nums :: [integer()]) -> [integer()].
single_number(Nums) ->
    Xor = lists:foldl(fun(N, Acc) -> Acc bxor N end, 0, Nums),
    Diff = Xor band (-Xor),
    [A, B] = lists:foldl(fun(N, [A, B]) ->
        case N band Diff of
            0 -> [A bxor N, B];
            _ -> [A, B bxor N]
        end
    end, [0, 0], Nums),
    [A, B].