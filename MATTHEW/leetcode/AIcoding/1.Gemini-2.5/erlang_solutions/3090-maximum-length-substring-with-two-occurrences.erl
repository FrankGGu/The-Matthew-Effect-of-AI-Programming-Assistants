-module(solution).
-export([maximumLengthSubstring/1]).

maximumLengthSubstring(S) ->
    % Convert string (list of chars) to an array for O(1) access
    CharArr = array:from_list(S),
    Len = array:size(CharArr),
    maximumLengthSubstring_recursive(CharArr, 0, 0, maps:new(), 0, Len).

maximumLengthSubstring_recursive(CharArr, Left, Right, FreqMap, MaxLen, Len) when Right < Len ->
    Char = array:get(Right, CharArr), % Get character at current Right index (0-based)

    CurrentCount = maps:get(Char, FreqMap, 0),
    NewFreqMap = maps:put(Char, CurrentCount + 1, FreqMap),

    case CurrentCount + 1 > 2 of
        true ->
            % Character count exceeded 2. Shrink window from Left.
            % We need to find the new Left and updated FreqMap.
            {NewLeft, AdjustedFreqMap} = shrink_until_valid(CharArr, Left, NewFreqMap, Char),

            CurrentWindowLength = Right - NewLeft + 1,
            NextMaxLen = max(MaxLen, CurrentWindowLength),

            maximumLengthSubstring_recursive(CharArr, NewLeft, Right + 1, AdjustedFreqMap, NextMaxLen, Len);
        false ->
            % Window is valid. Update max length.
            CurrentWindowLength = Right - Left + 1,
            NextMaxLen = max(MaxLen, CurrentWindowLength),

            maximumLengthSubstring_recursive(CharArr, Left, Right + 1, NewFreqMap, NextMaxLen, Len)
    end;
maximumLengthSubstring_recursive(_CharArr, _Left, _Right, _FreqMap, MaxLen, _Len) ->
    MaxLen.

shrink_until_valid(CharArr, CurrentLeft, FreqMap, ViolatingChar) ->
    ShrinkChar = array:get(CurrentLeft, CharArr),
    ShrinkCharCount = maps:get(ShrinkChar, FreqMap),

    UpdatedFreqMap = maps:put(ShrinkChar, ShrinkCharCount - 1, FreqMap),
    NewLeft = CurrentLeft + 1,

    case maps:get(ViolatingChar, UpdatedFreqMap) of
        2 ->
            {NewLeft, UpdatedFreqMap};
        _ ->
            shrink_until_valid(CharArr, NewLeft, UpdatedFreqMap, ViolatingChar)
    end.