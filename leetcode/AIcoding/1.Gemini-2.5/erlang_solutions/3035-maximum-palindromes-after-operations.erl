-module(solution).
-export([maximumPalindromes/2]).

maximumPalindromes(Words, Lengths) ->
    % 1. Count total character occurrences across all words
    % Initial counts: a list of 26 zeros, representing 'a' through 'z'
    InitialCountsList = lists:duplicate(26, 0),

    % Fold over words and then over characters in each word to update counts
    CharCounts = lists:foldl(
        fun(Word, AccCounts) ->
            lists:foldl(
                fun(Char, CurrentCounts) ->
                    Idx = Char - $a, % Convert char to 0-indexed integer (0 for 'a', 1 for 'b', etc.)
                    % lists:replace_at is 1-indexed, so use Idx + 1
                    lists:replace_at(Idx + 1, lists:nth(Idx + 1, CurrentCounts) + 1, CurrentCounts)
                end,
                AccCounts,
                Word
            )
        end,
        InitialCountsList,
        Words
    ),

    % 2. Calculate initial available pairs and odd characters from the total character counts
    % A pair consists of two identical characters. An odd character is a single one.
    {InitialPairs, InitialOddChars} = lists:foldl(
        fun(Count, {AccPairs, AccOdd}) ->
            {AccPairs + Count div 2, AccOdd + (Count rem 2)}
        end,
        {0, 0}, % Initial accumulator: {TotalPairs, TotalOddChars}
        CharCounts
    ),

    % 3. Sort lengths in ascending order. This is a greedy strategy to maximize palindromes.
    SortedLengths = lists:sort(Lengths),

    % 4. Iterate through sorted lengths, trying to form palindromes greedily
    % State: {CurrentAvailablePairs, CurrentAvailableOddChars, PalindromesFormedCount}
    {_, _, MaxPalindromes} = lists:foldl(
        fun(L, {CurrentPairs, CurrentOddChars, PalindromesCount}) ->
            % Required components for a palindrome of length L
            RequiredPairs = L div 2,
            RequiredOdd = L rem 2, % 1 if L is odd, 0 if L is even

            CanForm = false,
            NewCurrentPairs = CurrentPairs,
            NewCurrentOddChars = CurrentOddChars,

            % Check if we have enough pairs directly
            if CurrentPairs >= RequiredPairs ->
                % We have enough pairs directly. Use them.
                RemainingPairsAfterDirectUse = CurrentPairs - RequiredPairs,

                % Now, handle the odd character requirement
                if RequiredOdd == 1 ->
                    if CurrentOddChars >= 1 ->
                        % We have an odd character available, use it
                        NewCurrentPairs = RemainingPairsAfterDirectUse,
                        NewCurrentOddChars = CurrentOddChars - 1,
                        CanForm = true;
                    true -> % CurrentOddChars == 0, but we need an odd character
                        % Try to break one of the remaining pairs to get an odd character
                        if RemainingPairsAfterDirectUse >= 1 ->
                            NewCurrentPairs = RemainingPairsAfterDirectUse - 1, % One pair is broken
                            % The broken pair yields two single characters.
                            % One is used for the palindrome's center.
                            % The other becomes a new available odd character.
                            NewCurrentOddChars = CurrentOddChars + 1, % CurrentOddChars was 0, now it's 1.
                            CanForm = true;
                        true -> % No pairs left to break either
                            CanForm = false
                        end
                    end;
                true -> % RequiredOdd == 0, no odd character needed
                    NewCurrentPairs = RemainingPairsAfterDirectUse,
                    NewCurrentOddChars = CurrentOddChars,
                    CanForm = true
                end;
            true -> % CurrentPairs < RequiredPairs, not enough pairs directly
                % Calculate how many pairs we are short by
                PairsToGetFromOdds = RequiredPairs - CurrentPairs,
                % Each pair deficit requires 2 single characters from the 'odd' pool
                CharsNeededFromOddsForPairs = PairsToGetFromOdds * 2,

                % Calculate total single characters needed from the 'odd' pool
                TotalCharsNeededFromOddPool = CharsNeededFromOddsForPairs,
                if RequiredOdd == 1 ->
                    TotalCharsNeededFromOddPool = CharsNeededFromOddsForPairs + 1 % Add 1 for the center character
                end,

                % Check if we have enough single characters in the 'odd' pool
                if CurrentOddChars >= TotalCharsNeededFromOddPool ->
                    NewCurrentPairs = 0, % All original pairs are considered used/converted
                    NewCurrentOddChars = CurrentOddChars - TotalCharsNeededFromOddPool,
                    CanForm = true;
                true -> % Not enough single characters even from the 'odd' pool
                    CanForm = false
                end
            end,

            % Update state based on whether a palindrome was formed
            if CanForm ->
                {NewCurrentPairs, NewCurrentOddChars, PalindromesCount + 1};
            true ->
                {CurrentPairs, CurrentOddChars, PalindromesCount} % State remains unchanged
            end
        end,
        {InitialPairs, InitialOddChars, 0}, % Initial state for foldl
        SortedLengths
    ),
    MaxPalindromes.