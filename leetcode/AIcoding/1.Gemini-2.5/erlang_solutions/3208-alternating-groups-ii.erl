-module(solution).
-export([alternating_groups/2]).

alternating_groups(Colors, K) ->
    N = length(Colors),

    % Calculate GoodFlagsInt: a list of 0s and 1s
    % is_good[j] = (Colors[j] /= Colors[(j+1)%N]) AND (Colors[j] /= Colors[(j+2)%N])
    % We do this for j from 0 to N-1
    GoodFlagsInt = calculate_good_flags_int_optimized(Colors, N),

    % Create GoodFlagsIntExtended for circular sliding window
    % This list will have 2*N elements.
    GoodFlagsIntExtended = GoodFlagsInt ++ GoodFlagsInt,

    % Convert to array for O(1) access
    GoodFlagsArray = array:from_list(GoodFlagsIntExtended),

    % Sliding window sum
    % Initial window: elements from index 0 to K-1 (0-indexed)
    CurrentSum = 
        lists:foldl(fun(Idx, Acc) ->
                        Acc + array:get(Idx, GoodFlagsArray)
                    end, 0, lists:seq(0, K - 1)),

    % Count for the initial window
    Result = case CurrentSum of
                 K -> 1;
                 _ -> 0
             end,

    % Slide the window for the remaining N-1 positions
    % Idx represents the 0-indexed position of the element to be removed.
    % So, Idx goes from 0 to N-2.
    element(2, lists:foldl(fun(Idx, {CurrentSumAcc, CountAcc}) ->
                                RemovedVal = array:get(Idx, GoodFlagsArray),
                                AddedVal = array:get(Idx + K, GoodFlagsArray),

                                NewSum = CurrentSumAcc - RemovedVal + AddedVal,
                                NewCount = case NewSum of
                                               K -> CountAcc + 1;
                                               _ -> CountAcc
                                           end,
                                {NewSum, NewCount}
                        end, {CurrentSum, Result}, lists:seq(0, N - 2))).

calculate_good_flags_int_optimized(Colors, N) ->
    % Pad Colors for circular access without modulo
    % [C0, C1, ..., CN-1, C0, C1]
    C0 = lists:nth(1, Colors),
    C1 = lists:nth(2, Colors),
    PaddedColors = Colors ++ [C0, C1],

    % Use a helper function with sliding window of 3 elements
    lists:reverse(calculate_good_flags_int_helper_optimized(PaddedColors, N, [])).

calculate_good_flags_int_helper_optimized([C_j, C_j1, C_j2 | Rest], N, Acc) when N > 0 ->
    IsGood = case (C_j =/= C_j1) and (C_j =/= C_j2) of
                 true -> 1;
                 false -> 0
             end,
    calculate_good_flags_int_helper_optimized([C_j1, C_j2 | Rest], N - 1, [IsGood | Acc]);
calculate_good_flags_int_helper_optimized(_, 0, Acc) ->
    Acc.