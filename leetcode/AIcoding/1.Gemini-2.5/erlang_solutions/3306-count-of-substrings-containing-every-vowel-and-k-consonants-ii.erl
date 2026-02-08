-module(solution).
-export([countSubstrings/2]).

is_vowel(C) ->
    C == $a orelse C == $e orelse C == $i orelse C == $o orelse C == $u.

countSubstrings(Word, K) ->
    % Calculate count of substrings with at most K consonants and all 5 vowels.
    F_K = count_at_most(Word, K),

    % Calculate count of substrings with at most K-1 consonants and all 5 vowels.
    % If K is 0, then K-1 is -1, so this count should be 0.
    F_K_minus_1 = case K > 0 of
                      true -> count_at_most(Word, K - 1);
                      false -> 0
                  end,

    F_K - F_K_minus_1.

count_at_most(Word, MaxConsonants) ->
    WordList = string:to_list(Word),
    N = length(WordList),
    % State for the sliding window:
    % RightIdx: Current right pointer of the window.
    % Left: Left pointer for the "at most MaxConsonants" condition.
    % LeftVowelBoundary: Left pointer for the "all 5 vowels" condition.
    % ConsonantCount: Number of consonants in the window [Left, RightIdx].
    % VowelCounts: Map of vowel counts in the window [Left, RightIdx].
    % DistinctVowelCount: Number of distinct vowels in the window [Left, RightIdx].
    count_at_most_loop(WordList, N, MaxConsonants, 0, 0, 0, 0, #{}, 0).

count_at_most_loop(WordList, N, MaxConsonants, RightIdx, Left, LeftVowelBoundary, ConsonantCount, VowelCounts, DistinctVowelCount) when RightIdx < N ->
    Char = lists:nth(RightIdx + 1, WordList), % Get current character (1-indexed for lists:nth)

    % 1. Expand window by adding Char (update counts for [Left, RightIdx])
    NewConsonantCount = case is_vowel(Char) of
                            true -> ConsonantCount;
                            false -> ConsonantCount + 1
                        end,
    {NewVowelCounts, NewDistinctVowelCount} =
        case is_vowel(Char) of
            true ->
                OldCount = maps:get(Char, VowelCounts, 0),
                UpdatedVowelCounts = maps:put(Char, OldCount + 1, VowelCounts),
                UpdatedDistinctVowelCount = case OldCount == 0 of
                                                true -> DistinctVowelCount + 1;
                                                false -> DistinctVowelCount
                                            end,
                {UpdatedVowelCounts, UpdatedDistinctVowelCount};
            false ->
                {VowelCounts, DistinctVowelCount}
        end,

    % 2. Shrink 'Left' pointer to satisfy 'ConsonantCount <= MaxConsonants'
    % This updates Left, ConsonantCount, VowelCounts, and DistinctVowelCount for the window [ShrunkLeft, RightIdx].
    {ShrunkLeft, ShrunkConsonantCount, ShrunkVowelCounts, ShrunkDistinctVowelCount} =
        shrink_consonants_loop(WordList, Left, NewConsonantCount, MaxConsonants, NewVowelCounts, NewDistinctVowelCount),

    % 3. Adjust 'LeftVowelBoundary' pointer.
    % This pointer tracks the leftmost 'start' index such that the substring [start, RightIdx]
    % contains all 5 vowels. It must be at least 'ShrunkLeft'.
    AdjustedLeftVowelBoundary = max(LeftVowelBoundary, ShrunkLeft),

    % Simulate shrinking from AdjustedLeftVowelBoundary to find the actual leftmost start for all 5 vowels.
    % Note: ShrunkVowelCounts and ShrunkDistinctVowelCount are for the window [ShrunkLeft, RightIdx].
    % The `adjust_vowel_boundary_loop` uses these counts to determine how far LeftVowelBoundary can be moved.
    FinalLeftVowelBoundary =
        adjust_vowel_boundary_loop(WordList, AdjustedLeftVowelBoundary, RightIdx, ShrunkVowelCounts, ShrunkDistinctVowelCount),

    % 4. Add to the total count.
    % If the window [ShrunkLeft, RightIdx] (which satisfies MaxConsonants) also has all 5 vowels,
    % then valid substrings ending at RightIdx start from ShrunkLeft up to (FinalLeftVowelBoundary - 1).
    % The count of such starting points is (FinalLeftVowelBoundary - 1) - ShrunkLeft + 1
    % which simplifies to FinalLeftVowelBoundary - ShrunkLeft.
    CurrentAns = case ShrunkDistinctVowelCount == 5 of
                     true -> FinalLeftVowelBoundary - ShrunkLeft;
                     false -> 0
                 end,

    % Recurse for the next RightIdx, passing the updated state.
    % The `LeftVowelBoundary` for the next iteration should be `FinalLeftVowelBoundary`
    % as it represents the leftmost valid start for vowels for the current `RightIdx`.
    CurrentAns + count_at_most_loop(WordList, N, MaxConsonants, RightIdx + 1, ShrunkLeft, FinalLeftVowelBoundary, ShrunkConsonantCount, ShrunkVowelCounts, ShrunkDistinctVowelCount).

count_at_most_loop(_WordList, _N, _MaxConsonants, _RightIdx, _Left, _LeftVowelBoundary, _ConsonantCount, _VowelCounts, _DistinctVowelCount) ->
    0. % Base case: RightIdx == N, no more characters to process.

shrink_consonants_loop(WordList, Left, ConsonantCount, MaxConsonants, VowelCounts, DistinctVowelCount) ->
    if ConsonantCount > MaxConsonants ->
        LeftChar = lists:nth(Left + 1, WordList),
        NewConsonantCount = case is_vowel(LeftChar) of
                                true -> ConsonantCount;
                                false -> ConsonantCount - 1
                            end,
        {NewVowelCounts, NewDistinctVowelCount} =
            case is_vowel(LeftChar) of
                true ->
                    OldCount = maps:get(LeftChar, VowelCounts),
                    UpdatedVowelCounts = maps:put(LeftChar, OldCount - 1, VowelCounts),
                    UpdatedDistinctVowelCount = case OldCount == 1 of
                                                    true -> DistinctVowelCount - 1;
                                                    false -> DistinctVowelCount
                                                end,
                    {UpdatedVowelCounts, UpdatedDistinctVowelCount};
                false ->
                    {VowelCounts, DistinctVowelCount}
            end,
        shrink_consonants_loop(WordList, Left + 1, NewConsonantCount, MaxConsonants, NewVowelCounts, NewDistinctVowelCount);
    true ->
        {Left, ConsonantCount, VowelCounts, DistinctVowelCount}
    end.

adjust_vowel_boundary_loop(WordList, LeftVowelBoundary, RightIdx, VowelCounts, DistinctVowelCount) ->
    if DistinctVowelCount == 5 and LeftVowelBoundary <= RightIdx ->
        LeftChar = lists:nth(LeftVowelBoundary + 1, WordList),
        case is_vowel(LeftChar) of
            true ->
                OldCount = maps:get(LeftChar, VowelCounts),
                if OldCount == 1 ->
                    % If removing this vowel makes its count 0, it's essential.
                    % So, LeftVowelBoundary is the earliest possible start index.
                    LeftVowelBoundary;
                true ->
                    % This vowel has count > 1, so we can hypothetically remove it
                    % without losing a distinct vowel.
                    NewVowelCounts = maps:put(LeftChar, OldCount - 1, VowelCounts),
                    adjust_vowel_boundary_loop(WordList, LeftVowelBoundary + 1, RightIdx, NewVowelCounts, DistinctVowelCount)
                end;
            false ->
                % It's a consonant, removing it doesn't affect distinct vowel count.
                adjust_vowel_boundary_loop(WordList, LeftVowelBoundary + 1, RightIdx, VowelCounts, DistinctVowelCount)
        end;
    true ->
        % Either DistinctVowelCount is not 5 (meaning [ShrunkLeft, RightIdx] didn't have all 5 vowels),
        % or LeftVowelBoundary has moved past RightIdx.
        LeftVowelBoundary
    end.