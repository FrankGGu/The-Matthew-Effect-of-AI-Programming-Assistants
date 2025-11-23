-module(solution).
-export([sampleStatistics/1]).

sampleStatistics(Sample) ->
    Count = length(Sample),
    Sum = lists:sum(Sample),
    Mean = Sum / Count,
    Min = lists:min(Sample),
    Max = lists:max(Sample),
    Variance = lists:foldl(fun(X, Acc) -> Acc + (X - Mean) * (X - Mean) end, 0, Sample) / Count,
    StdDev = math:sqrt(Variance),
    [Mean, StdDev, Min, Max].