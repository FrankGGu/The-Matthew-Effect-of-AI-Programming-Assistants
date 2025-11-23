-module(solution).
-export([min_operations/2]).

min_operations(Nums, _K) ->
    SortedNums = lists:sort(Nums),
    Len = length(SortedNums),

    % The target value x that minimizes sum(|nums[i] - x|) is the median of the array.
    % For a 0-indexed array, the median index is (Len - 1) div 2.
    % For Erlang's 1-indexed lists: (Len - 1) div 2 + 1.
    MedianIdx = (Len - 1) div 2 + 1,
    MedianVal = lists:nth(MedianIdx, SortedNums),

    % Calculate the total number of operations
    lists:foldl(fun(Num, Acc) ->
                    Acc + abs(Num - MedianVal)
                end, 0, SortedNums).