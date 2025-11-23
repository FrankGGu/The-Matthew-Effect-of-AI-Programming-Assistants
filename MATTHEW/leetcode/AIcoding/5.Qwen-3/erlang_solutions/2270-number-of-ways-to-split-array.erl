-module(solve).
-export([num_ways/1]).

num_ways(nums) ->
    Num = length(nums),
    Total = lists:sum(nums),
    Count = 0,
    Helper(1, Total, nums, Count).

Helper(_I, _Total, [], Count) ->
    Count;
Helper(I, Total, [H | T], Count) ->
    LeftSum = lists:sublist(nums, I),
    LeftSumInt = lists:sum(LeftSum),
    RightSum = Total - LeftSumInt,
    if
        RightSum >= LeftSumInt ->
            Helper(I + 1, Total, T, Count + 1);
        true ->
            Helper(I + 1, Total, T, Count)
    end.