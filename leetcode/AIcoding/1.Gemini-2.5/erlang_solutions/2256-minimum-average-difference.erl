-module(solution).
-export([minimumAverageDifference/1]).

minimumAverageDifference(Nums) ->
    N = length(Nums),
    TotalSum = lists:sum(Nums),

    % Start recursion with initial state:
    % Index, LeftSumAcc, TotalSum, N, RemainingNums, CurrentMinDiff, CurrentMinIndex
    % CurrentMinDiff is set to 'infinity' so the first calculated difference will always be smaller.
    % CurrentMinIndex is set to 0, which is the first possible index.
    solve_recursive(0, 0, TotalSum, N, Nums, infinity, 0).

solve_recursive(Index, LeftSumAcc, TotalSum, N, [Element|Tail], CurrentMinDiff, CurrentMinIndex) when Index < N ->
    NewLeftSumAcc = LeftSumAcc + Element,

    LeftAvg = NewLeftSumAcc div (Index + 1),

    RightSum = TotalSum - NewLeftSumAcc,
    RightCount = N - (Index + 1),

    RightAvg = 
        if 
            RightCount == 0 -> 0;
            true -> RightSum div RightCount
        end,

    Diff = abs(LeftAvg - RightAvg),

    % Update minimum if a strictly smaller difference is found.
    % If Diff is equal, keep the existing CurrentMinIndex to satisfy the "smallest index" requirement.
    if 
        Diff < CurrentMinDiff ->
            solve_recursive(Index + 1, NewLeftSumAcc, TotalSum, N, Tail, Diff, Index);
        true -> % Diff >= CurrentMinDiff, keep current min and index
            solve_recursive(Index + 1, NewLeftSumAcc, TotalSum, N, Tail, CurrentMinDiff, CurrentMinIndex)
    end;
solve_recursive(N, _LeftSumAcc, _TotalSum, _N, [], _CurrentMinDiff, CurrentMinIndex) ->
    % Base case: all indices processed, return the stored minimum index
    CurrentMinIndex.