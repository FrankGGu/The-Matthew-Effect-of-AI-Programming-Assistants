-spec minimum_average_difference(Nums :: [integer()]) -> integer().
minimum_average_difference(Nums) ->
    Sum = lists:sum(Nums),
    N = length(Nums),
    {MinDiff, MinIndex, LeftSum} = lists:foldl(
        fun(X, {CurrentMinDiff, CurrentMinIndex, CurrentLeftSum}) ->
            LeftSum1 = CurrentLeftSum + X,
            LeftAvg = LeftSum1 div (CurrentMinIndex + 1),
            RightSum = Sum - LeftSum1,
            RightAvg = case N - CurrentMinIndex - 1 of
                0 -> 0;
                Div -> RightSum div Div
            end,
            Diff = abs(LeftAvg - RightAvg),
            if
                Diff < CurrentMinDiff -> {Diff, CurrentMinIndex, LeftSum1};
                true -> {CurrentMinDiff, CurrentMinIndex, LeftSum1}
            end
        end,
        {abs(Sum div N), N - 1, 0},
        lists:seq(1, N - 1)
    ),
    case N of
        1 -> 0;
        _ -> MinIndex
    end.