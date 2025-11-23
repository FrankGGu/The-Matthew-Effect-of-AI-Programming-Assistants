-module(solution).
-export([findTheLongestSubstring/1]).

findTheLongestSubstring(S) ->
    VowelMasks = #{
        $a => 1,  % 00001
        $e => 2,  % 00010
        $i => 4,  % 00100
        $o => 8,  % 01000
        $u => 16  % 10000
    },

    % Accumulator: {MaxLen, CurrentMask, MaskToIndexMap, CurrentIndex}
    % MaxLen: The maximum length found so far.
    % CurrentMask: The XOR sum of vowel parities for the prefix up to CurrentIndex.
    % MaskToIndexMap: A map from a mask value to the *first* index where that mask was encountered.
    % CurrentIndex: The 0-based index of the character currently being processed.
    % Initialize: MaxLen = 0, CurrentMask = 0, MaskToIndexMap = #{0 => -1}, CurrentIndex = -1.
    % The entry #{0 => -1} handles the case where a prefix itself has all even counts,
    % allowing a length calculation like `CurrentIndex - (-1) = CurrentIndex + 1`.

    lists:foldl(
        fun(Char, {MaxLen, CurrentMask, MaskToIndexMap, Index}) ->
            NewIndex = Index + 1,

            % Determine the mask delta for the current character.
            % If it's a vowel, get its corresponding bitmask. Otherwise, 0.
            MaskDelta = maps:get(Char, VowelMasks, 0),

            % Update the current mask by XORing with the delta.
            NewMask = CurrentMask bxor MaskDelta,

            % Check if this NewMask has been seen before.
            case maps:find(NewMask, MaskToIndexMap) of
                {ok, PrevIndex} ->
                    % If seen, it means the substring from PrevIndex + 1 to NewIndex
                    % has all vowels in even counts.
                    % Calculate its length and update MaxLen if it's greater.
                    Length = NewIndex - PrevIndex,
                    {max(MaxLen, Length), NewMask, MaskToIndexMap, NewIndex};

                error ->
                    % If not seen, store this mask's first occurrence index.
                    NewMaskToIndexMap = maps:put(NewMask, NewIndex, MaskToIndexMap),
                    {MaxLen, NewMask, NewMaskToIndexMap, NewIndex}
            end
        end,
        {0, 0, #{0 => -1}, -1}, % Initial accumulator state
        S
    )
    % After processing all characters, the first element of the final accumulator
    % tuple contains the maximum length.
    -> {FinalMaxLen, _, _, _}
    FinalMaxLen.