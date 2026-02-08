-module(solution).
-export([longestSubstring/1]).

vowel_val(Char) ->
    case Char of
        $a -> 0;
        $e -> 1;
        $i -> 2;
        $o -> 3;
        $u -> 4;
        _ -> -1
    end.

longestSubstring(Word) ->
    % State: {CurrentLength, CurrentVowelBitmask, LastVowelIndex, MaxLength}
    % CurrentVowelBitmask: A bitmask representing the set of unique vowels encountered in the current substring.
    %                      (1 bsl 0) for 'a', (1 bsl 1) for 'e', etc.
    %                      The value 31 (binary 11111) means all five vowels ('a' through 'u') are present.
    % LastVowelIndex: The integer index (0-4) of the last vowel character added to the current substring.
    %                 Used to enforce the non-decreasing order (char[i] >= char[i-1]).
    InitialState = {0, 0, -1, 0},

    {_CLen, _CVBitmask, _LVIdx, MaxLen} = lists:foldl(
        fun(Char, {CLen, CVBitmask, LVIdx, MLen}) ->
            VIdx = vowel_val(Char),

            if
                VIdx == -1 -> % Not a vowel, reset current sequence
                    {0, 0, -1, MLen};
                CLen == 0 -> % Starting a new potential vowel substring
                    if VIdx == 0 -> % A valid vowel substring must start with 'a'
                        {1, (1 bsl 0), 0, MLen};
                    true -> % Not 'a', ignore and wait for an 'a' to start a new sequence
                        {0, 0, -1, MLen}
                    end;
                VIdx >= LVIdx -> % Non-decreasing order is maintained (current vowel is same or greater than last)
                    NewCLen = CLen + 1,
                    NewCVBitmask = CVBitmask bor (1 bsl VIdx), % Add current vowel to the set
                    NewLVIdx = VIdx, % Update the last vowel index
                    NewMLen = if NewCVBitmask == 31 -> % Check if all 5 vowels are now present
                                  max(MLen, NewCLen);
                              true ->
                                  MLen
                              end,
                    {NewCLen, NewCVBitmask, NewLVIdx, NewMLen};
                true -> % VIdx < LVIdx, the non-decreasing order is broken. Reset current sequence.
                    if VIdx == 0 -> % Current character is 'a', so we can start a new sequence from here
                        {1, (1 bsl 0), 0, MLen};
                    true -> % Current character is not 'a', so we cannot start a new valid sequence here
                        {0, 0, -1, MLen}
                    end
            end
        end,
        InitialState,
        Word
    ),
    MaxLen.