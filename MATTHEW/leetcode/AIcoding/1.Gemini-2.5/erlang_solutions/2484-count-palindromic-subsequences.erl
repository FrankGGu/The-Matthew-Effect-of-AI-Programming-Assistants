-module(solution).
-export([countPalindromicSubsequences/1]).

-include_lib("stdlib/include/array.hrl").

countPalindromicSubsequences(S) ->
    N = length(S),
    Mod = 1000000007,

    S_int_array = array:from_list([C - $0 || C <- S]),

    % count_prefix[idx][digit] = count of digit in S[0...idx-1]
    % Size N+1 x 10
    CountPrefix = array:new([{size, N + 1}, {fixed, true}, {default, array:new([{size, 10}, {fixed, true}, {default, 0}])}]),
    CountPrefix1 = calculate_count_prefix(S_int_array, N, CountPrefix, 0),

    % count_suffix[idx][digit] = count of digit in S[idx...N-1]
    % Size N+1 x 10
    CountSuffix = array:new([{size, N + 1}, {fixed, true}, {default, array:new([{size, 10}, {fixed, true}, {default, 0}])}]),
    CountSuffix1 = calculate_count_suffix(S_int_array, N, CountSuffix, N),

    % num_xy_left[idx][char_x][char_y] = number of subsequences char_x char_y in S[0...idx-1]
    % Size N+1 x 10 x 10
    NumXYLeft = array:new([{size, N + 1}, {fixed, true}, {default, array:new([{size, 10}, {fixed, true}, {default, array:new([{size, 10}, {fixed, true}, {default, 0}])}])}]),
    NumXYLeft1 = calculate_num_xy_left(S_int_array, N, CountPrefix1, NumXYLeft, 0),

    % num_yx_right[idx][char_y][char_x] = number of subsequences char_y char_x in S[idx...N-1]
    % Size N+1 x 10 x 10
    NumYXRight = array:new([{size, N + 1}, {fixed, true}, {default, array:new([{size, 10}, {fixed, true}, {default, array:new([{size, 10}, {fixed, true}, {default, 0}])}])}]),
    NumYXRight1 = calculate_num_yx_right(S_int_array, N, CountSuffix1, NumYXRight, N),

    TotalAns = calculate_total_ans(N, NumXYLeft1, NumYXRight1, Mod, 0),
    TotalAns.

calculate_count_prefix(S_int_array, N, CountPrefixArray, CurrentIdx) when CurrentIdx < N ->
    PrevCounts = array:get(CurrentIdx, CountPrefixArray),
    Char = array:get(CurrentIdx, S_int_array),
    UpdatedCounts = array:set(Char, array:get(Char, PrevCounts) + 1, PrevCounts),
    calculate_count_prefix(S_int_array, N, array:set(CurrentIdx + 1, UpdatedCounts, CountPrefixArray), CurrentIdx + 1);
calculate_count_prefix(_S_int_array, _N, CountPrefixArray, _CurrentIdx) ->
    CountPrefixArray.

calculate_count_suffix(S_int_array, N, CountSuffixArray, CurrentIdx) when CurrentIdx > 0 ->
    PrevCounts = array:get(CurrentIdx, CountSuffixArray),
    Char = array:get(CurrentIdx - 1, S_int_array),
    UpdatedCounts = array:set(Char, array:get(Char, PrevCounts) + 1, PrevCounts),
    calculate_count_suffix(S_int_array, N, array:set(CurrentIdx - 1, UpdatedCounts, CountSuffixArray), CurrentIdx - 1);
calculate_count_suffix(_S_int_array, _N, CountSuffixArray, _CurrentIdx) ->
    CountSuffixArray.

calculate_num_xy_left(S_int_array, N, CountPrefixArray, NumXYLeftArray, CurrentIdx) when CurrentIdx =< N ->
    PrevNumXYLeftRow = case CurrentIdx > 0 of
                           true -> array:get(CurrentIdx - 1, NumXYLeftArray);
                           false -> array:new([{size, 10}, {fixed, true}, {default, array:new([{size, 10}, {fixed, true}, {default, 0}])}])
                       end,
    NextNumXYLeftArray = array:set(CurrentIdx, PrevNumXYLeftRow, NumXYLeftArray),

    case CurrentIdx > 0 of
        true ->
            Char_y = array:get(CurrentIdx - 1, S_int_array),
            PrevPrefixCounts = array:get(CurrentIdx - 1, CountPrefixArray),

            CurrentNumXYLeftRow = array:get(CurrentIdx, NextNumXYLeftArray),
            UpdatedNumXYLeftRow = update_num_xy_left_row(Char_y, PrevPrefixCounts, CurrentNumXYLeftRow),
            calculate_num_xy_left(S_int_array, N, CountPrefixArray, array:set(CurrentIdx, UpdatedNumXYLeftRow, NextNumXYLeftArray), CurrentIdx + 1);
        false ->
            calculate_num_xy_left(S_int_array, N, CountPrefixArray, NextNumXYLeftArray, CurrentIdx + 1)
    end;
calculate_num_xy_left(_S_int_array, _N, _CountPrefixArray, NumXYLeftArray, _CurrentIdx) -> NumXYLeftArray.

update_num_xy_left_row(Char_y, PrevPrefixCounts, CurrentNumXYLeftRow) ->
    lists:foldl(fun(Char_x, AccRow) ->
        Count_x = array:get(Char_x, PrevPrefixCounts),
        Char_x_Row = array:get(Char_x, AccRow),
        CurrentCount = array:get(Char_y, Char_x_Row),
        UpdatedCount = CurrentCount + Count_x,
        array:set(Char_x, array:set(Char_y, UpdatedCount, Char_x_Row), AccRow)
    end, CurrentNumXYLeftRow, lists:seq(0, 9)).

calculate_num_yx_right(S_int_array, N, CountSuffixArray, NumYXRightArray, CurrentIdx) when CurrentIdx >= 0 ->
    PrevNumYXRightRow = case CurrentIdx < N of
                            true -> array:get(CurrentIdx + 1, NumYXRightArray);
                            false -> array:new([{size, 10}, {fixed, true}, {default, array:new([{size, 10}, {fixed, true}, {default, 0}])}])
                        end,
    NextNumYXRightArray = array:set(CurrentIdx, PrevNumYXRightRow, NumYXRightArray),

    case CurrentIdx < N of
        true ->
            Char_y = array:get(CurrentIdx, S_int_array),
            PrevSuffixCounts = array:get(CurrentIdx + 1, CountSuffixArray),

            CurrentNumYXRightRow = array:get(CurrentIdx, NextNumYXRightArray),
            UpdatedNumYXRightRow = update_num_yx_right_row(Char_y, PrevSuffixCounts, CurrentNumYXRightRow),
            calculate_num_yx_right(S_int_array, N, CountSuffixArray, array:set(CurrentIdx, UpdatedNumYXRightRow, NextNumYXRightArray), CurrentIdx - 1);
        false ->
            calculate_num_yx_right(S_int_array, N, CountSuffixArray, NextNumYXRightArray, CurrentIdx - 1)
    end;
calculate_num_yx_right(_S_int_array, _N, _CountSuffixArray, NumYXRightArray, _CurrentIdx) -> NumYXRightArray.

update_num_yx_right_row(Char_y, PrevSuffixCounts, CurrentNumYXRightRow) ->
    lists:foldl(fun(Char_x, AccRow) ->
        Count_x = array:get(Char_x, PrevSuffixCounts),
        Char_x_Row = array:get(Char_x, AccRow),
        CurrentCount = array:get(Char_y, Char_x_Row),
        UpdatedCount = CurrentCount + Count_x,
        array:set(Char_x, array:set(Char_y, UpdatedCount, Char_x_Row), AccRow)
    end, CurrentNumYXRightRow, lists:seq(0, 9)).

calculate_total_ans(N, NumXYLeftArray, NumYXRightArray, Mod, Acc) ->
    lists:foldl(fun(J, CurrentAcc) ->
        lists:foldl(fun(Char_x, InnerAcc1) ->
            lists:foldl(fun(Char_y, InnerAcc2) ->
                LeftCount = array:get(Char_y, array:get(Char_x, array:get(J, NumXYLeftArray))),
                RightCount = array:get(Char_x, array:get(Char_y, array:get(J + 1, NumYXRightArray))),
                (InnerAcc2 + (LeftCount * RightCount) rem Mod) rem Mod
            end, InnerAcc1, lists:seq(0, 9))
        end, CurrentAcc, lists:seq(0, 9))
    end, Acc, lists:seq(0, N - 1)).