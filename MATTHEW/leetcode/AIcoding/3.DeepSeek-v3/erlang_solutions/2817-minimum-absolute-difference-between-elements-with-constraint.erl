-spec min_absolute_difference(Nums :: [integer()], X :: integer()) -> integer().
min_absolute_difference(Nums, X) ->
    N = length(Nums),
    MinDiff = lists:foldl(
        fun(I, Acc) ->
            J = I + X,
            if
                J >= N -> Acc;
                true ->
                    Diff = abs(lists:nth(I + 1, Nums) - lists:nth(J + 1, Nums)),
                    if
                        Diff < Acc -> Diff;
                        true -> Acc
                    end
            end
        end,
        infinity,
        lists:seq(0, N - 1)
    ),
    MinDiff.