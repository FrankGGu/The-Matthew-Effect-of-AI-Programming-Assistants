-module(solution).
-export([solution/1]).

solution(Arr) ->
    N = length(Arr),
    InitialResultArray = array:new(N, {default, 0}),

    % Group indices by value.
    % The lists will be in reverse order of indices initially.
    ReversedIndicesMap = lists:foldl(
        fun({Val, Idx}, AccMap) ->
            maps:update_with(Val, fun(L) -> [Idx|L] end, [], AccMap)
        end,
        maps:new(),
        lists:zip(Arr, lists:seq(0, N - 1))
    ),

    % Calculate results for each group of indices
    FinalResultArray = maps:fold(
        fun(_Value, ReversedIndices, CurrentResultArray) ->
            % Reverse the list of indices to get them in ascending order
            Indices = lists:reverse(ReversedIndices),
            calculate_for_indices(Indices, CurrentResultArray)
        end,
        InitialResultArray,
        ReversedIndicesMap
    ),

    array:to_list(FinalResultArray).

calculate_for_indices(Indices, ResultArray) ->
    TotalSum = lists:sum(Indices),
    TotalCount = length(Indices),

    % Initial state for the sliding window calculation
    LeftSum = 0,
    LeftCount = 0,
    RightSum = TotalSum,
    RightCount = TotalCount,

    calculate_loop(Indices, LeftSum, LeftCount, RightSum, RightCount, ResultArray).

calculate_loop([H|T], LeftSum, LeftCount, RightSum, RightCount, AccResultArray) ->
    % H is the current index being processed.
    % Initially, H is considered part of the 'right' side.

    % Update RightSum and RightCount to exclude H
    NewRightSum = RightSum - H,
    NewRightCount = RightCount - 1,

    % Calculate the answer for the current index H
    % (H * LeftCount - LeftSum): Sum of |H - p_j| for all p_j < H
    % (NewRightSum - H * NewRightCount): Sum of |p_j - H| for all p_j > H
    CurrentAns = (H * LeftCount - LeftSum) + (NewRightSum - H * NewRightCount),

    % Store the calculated result in the array at index H
    UpdatedAccResultArray = array:set(H, CurrentAns, AccResultArray),

    % Update LeftSum and LeftCount to include H for the next iteration
    NewLeftSum = LeftSum + H,
    NewLeftCount = LeftCount + 1,

    % Continue processing the rest of the indices
    calculate_loop(T, NewLeftSum, NewLeftCount, NewRightSum, NewRightCount, UpdatedAccResultArray);
calculate_loop([], _LeftSum, _LeftCount, _RightSum, _RightCount, AccResultArray) ->
    % Base case: all indices for this value have been processed
    AccResultArray.