-module(minimum_average_difference).
-export([minimumAverageDifference/1]).

minimumAverageDifference(Nums) ->
    N = length(Nums),
    Total = lists:sum(Nums),
    MinIndex = 0,
    MinDiff = infinity,
    loop(0, 0, Total, N, MinIndex, MinDiff, Nums).

loop(I, LeftSum, Total, N, MinIndex, MinDiff, Nums) when I < N ->
    RightSum = Total - LeftSum,
    AvgLeft = LeftSum / I,
    AvgRight = RightSum / (N - I),
    Diff = math:abs(AvgLeft - AvgRight),
    if
        Diff < MinDiff ->
            loop(I + 1, LeftSum + lists:nth(I + 1, Nums), Total, N, I, Diff, Nums);
        true ->
            loop(I + 1, LeftSum + lists:nth(I + 1, Nums), Total, N, MinIndex, MinDiff, Nums)
    end;
loop(_, _, _, _, MinIndex, _, _) ->
    MinIndex.