-module(solution).
-export([max_confusion/2]).

max_confusion(AnswerKey, K) ->
    TupleKey = list_to_tuple(AnswerKey),
    Len = tuple_size(TupleKey),

    % Calculate max length for 'T' as target character (meaning 'F' is the 'other' character)
    MaxT = solve_for_char_tuple(TupleKey, K, Len, $F),

    % Calculate max length for 'F' as target character (meaning 'T' is the 'other' character)
    MaxF = solve_for_char_tuple(TupleKey, K, Len, $T),

    max(MaxT, MaxF).

solve_for_char_tuple(TupleKey, K, TotalLen, OtherChar) ->
    % LeftIdx: start of the sliding window (0-indexed)
    % RightIdx: end of the sliding window (0-indexed, current char being added)
    % OtherCount: count of 'OtherChar' in the current window [LeftIdx, RightIdx-1]
    % MaxLen: maximum window length found so far
    solve_for_char_tuple_loop(TupleKey, K, OtherChar, 0, 0, 0, 0, TotalLen).

solve_for_char_tuple_loop(TupleKey, K, OtherChar, LeftIdx, RightIdx, OtherCount, MaxLen, TotalLen) ->
    if RightIdx == TotalLen ->
        MaxLen;
    true ->
        % Add current character at RightIdx to the window
        CurrentChar = element(RightIdx + 1, TupleKey), % element/2 is 1-indexed
        NewOtherCount = if CurrentChar == OtherChar -> OtherCount + 1; true -> OtherCount end,

        % Shrink window from left if OtherCount exceeds K
        {FinalLeftIdx, FinalOtherCount} = shrink_window_loop(TupleKey, OtherChar, LeftIdx, NewOtherCount, K),

        % Calculate current window length and update max_len
        CurrentWindowLen = RightIdx - FinalLeftIdx + 1,
        NewMaxLen = max(MaxLen, CurrentWindowLen),

        % Move right pointer to the next character
        solve_for_char_tuple_loop(TupleKey, K, OtherChar, FinalLeftIdx, RightIdx + 1, FinalOtherCount, NewMaxLen, TotalLen)
    end.

shrink_window_loop(TupleKey, OtherChar, LeftIdx, OtherCount, K) ->
    if OtherCount > K ->
        % Remove character at LeftIdx from the window
        LeftChar = element(LeftIdx + 1, TupleKey), % element/2 is 1-indexed
        NewOtherCount = if LeftChar == OtherChar -> OtherCount - 1; true -> OtherCount end,
        % Move left pointer to the right
        shrink_window_loop(TupleKey, OtherChar, LeftIdx + 1, NewOtherCount, K);
    true ->
        % Window is valid, return current state
        {LeftIdx, OtherCount}
    end.