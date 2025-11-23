-module(solution).
-export([find_largest_outlier/1]).

find_largest_outlier(Nums) ->
    Sum = lists:sum(Nums),
    Len = length(Nums),
    Mean = Sum / Len,
    {MaxDiff, MaxVal} = lists:foldl(
        fun(Num, {CurrentMaxDiff, CurrentMaxVal}) ->
            Diff = abs(Num - Mean),
            if
                Diff > CurrentMaxDiff -> {Diff, Num};
                Diff == CurrentMaxDiff -> {Diff, max(Num, CurrentMaxVal)};
                true -> {CurrentMaxDiff, CurrentMaxVal}
            end
        end,
        {0, hd(Nums)},
        Nums
    ),
    MaxVal.