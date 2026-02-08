-spec dominant_index(Nums :: [integer()]) -> integer().
dominant_index(Nums) ->
    case Nums of
        [] -> -1;
        [_] -> 0;
        _ ->
            {Max1, Max2, Index} = lists:foldl(fun
                (Num, {M1, M2, I}) when Num > M1 -> {Num, M1, I + 1};
                (Num, {M1, M2, I}) when Num > M2 -> {M1, Num, I};
                (_, Acc) -> Acc
            end, {-1, -1, 0}, Nums),
            if
                Max1 >= 2 * Max2 -> Index - 1;
                true -> -1
            end
    end.