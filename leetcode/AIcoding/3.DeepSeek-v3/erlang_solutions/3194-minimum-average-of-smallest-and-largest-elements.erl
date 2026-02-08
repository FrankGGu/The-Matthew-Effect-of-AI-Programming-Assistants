-spec minimum_average_diff(Nums :: [integer()]) -> integer().
minimum_average_diff(Nums) ->
    Sum = lists:sum(Nums),
    N = length(Nums),
    minimum_average_diff(Nums, 0, Sum, 0, N, 0, infinity, -1).

minimum_average_diff([], _, _, LeftSum, _, Index, MinAvg, MinIndex) ->
    MinIndex;
minimum_average_diff([H | T], I, TotalSum, LeftSum, N, Index, MinAvg, MinIndex) ->
    LeftSum1 = LeftSum + H,
    RightSum = TotalSum - LeftSum1,
    LeftAvg = LeftSum1 div (I + 1),
    RightAvg = case N - I - 1 of
        0 -> 0;
        Div -> RightSum div Div
    end,
    CurrentAvg = abs(LeftAvg - RightAvg),
    {NewMinAvg, NewMinIndex} = if
        CurrentAvg < MinAvg -> {CurrentAvg, I};
        CurrentAvg == MinAvg andalso I < MinIndex -> {CurrentAvg, I};
        true -> {MinAvg, MinIndex}
    end,
    minimum_average_diff(T, I + 1, TotalSum, LeftSum1, N, Index + 1, NewMinAvg, NewMinIndex).