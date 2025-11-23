-module(solution).
-export([findSubstringInWraproundString/1]).

findSubstringInWraproundString(P) ->
    if P == [] ->
        0;
    true ->
        % Initialize max_len for each char 'a' through 'z' to 0.
        % This is a tuple of 26 elements, where element N corresponds to the N-th letter (1-indexed).
        % e.g., element 1 for 'a', element 2 for 'b', ..., element 26 for 'z'.
        InitialMaxLen = list_to_tuple(lists:duplicate(26, 0)),

        % Use lists:foldl to iterate through the string and accumulate state.
        % The state is a tuple: {CurrentLength, PrevChar, MaxLenTuple}.
        % CurrentLength: The length of the current contiguous wraparound substring ending at PrevChar.
        % PrevChar: The character processed in the previous iteration.
        % MaxLenTuple: The tuple storing the maximum wraparound substring length for each character.
        % Initial state: CurrentLength=0 (to signify the start), PrevChar=dummy_char, MaxLenTuple=all zeros.
        {_FinalCurrentLength, _FinalPrevChar, FinalMaxLen} = lists:foldl(
            fun(Char, {CurrentLength, PrevChar, AccMaxLen}) ->
                % Determine the new current length based on the current character and the previous one.
                NewCurrentLength = 
                    if
                        CurrentLength == 0 -> % This is the first character of the string P
                            1;
                        (Char - PrevChar == 1) or (PrevChar == $z and Char == $a) -> % Wraparound sequence continues
                            CurrentLength + 1;
                        true -> % Wraparound sequence is broken
                            1
                    end,

                % Calculate the 1-based index for the current character in the MaxLenTuple.
                CharIndex = Char - $a + 1,

                % Update the MaxLenTuple for the current character.
                % We store the maximum length found so far for any wraparound substring ending with 'Char'.
                OldMaxForChar = element(CharIndex, AccMaxLen),
                UpdatedMaxForChar = max(OldMaxForChar, NewCurrentLength),
                NewAccMaxLen = setelement(CharIndex, AccMaxLen, UpdatedMaxForChar),

                % Return the updated state for the next iteration.
                {NewCurrentLength, Char, NewAccMaxLen}
            end,
            {0, $$, InitialMaxLen}, % Initial state for foldl (0 for CurrentLength, $$ for dummy PrevChar)
            P
        ),

        % The total number of unique substrings is the sum of all maximum lengths stored in FinalMaxLen.
        % Convert the tuple back to a list to use lists:sum.
        lists:sum(tuple_to_list(FinalMaxLen))
    end.