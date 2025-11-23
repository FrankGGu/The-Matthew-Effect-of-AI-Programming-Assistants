-module(maximum_average_pass_ratio).
-export([diffs/2]).

diffs(Students, Exams) ->
    Passes = [lists:nth(1, Student) || Student <- Students],
    Total = [lists:nth(2, Student) || Student <- Students],
    Ratio = lists:zipwith(fun(P, T) -> P / T end, Passes, Total),
    {RatioList, Indexes} = lists:foldl(
        fun(I, {Acc, AccIndexes}) ->
            {lists:append(Acc, [lists:nth(1, Students -- lists:nth(I, Students)) / (lists:nth(2, Students -- lists:nth(I, Students)))]), 
             lists:append(AccIndexes, [I])}
        end,
        {[], []},
        lists:seq(0, length(Students) - 1)
    ),
    Sorted = lists:sort(fun({A, _}, {B, _}) -> A > B end, lists:zip(RatioList, Indexes)),
    [Index | _] = [I || {_, I} <- Sorted],
    lists:nth(Index + 1, Students).

-maxAveragePassRatio/2.
maxAveragePassRatio(Students, K) ->
    Passes = [lists:nth(1, Student) || Student <- Students],
    Total = [lists:nth(2, Student) || Student <- Students],
    Ratio = lists:zipwith(fun(P, T) -> P / T end, Passes, Total),
    {RatioList, Indexes} = lists:foldl(
        fun(I, {Acc, AccIndexes}) ->
            {lists:append(Acc, [lists:nth(1, Students -- lists:nth(I, Students)) / (lists:nth(2, Students -- lists:nth(I, Students)))]), 
             lists:append(AccIndexes, [I])}
        end,
        {[], []},
        lists:seq(0, length(Students) - 1)
    ),
    Sorted = lists:sort(fun({A, _}, {B, _}) -> A > B end, lists:zip(RatioList, Indexes)),
    [Index | _] = [I || {_, I} <- Sorted],
    lists:nth(Index + 1, Students).