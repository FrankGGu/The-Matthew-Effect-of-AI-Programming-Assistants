-module(solution).
-export([countValidWords/1]).

is_lower(C) when C >= $a, C <= $z -> true;
is_lower(_) -> false.

is_punctuation(C) when C == $!, C == $., C == $, -> true;
is_punctuation(_) -> false.

is_digit(C) when C >= $0, C <= $9 -> true;
is_digit(_) -> false.

countValidWords(Sentence) ->
    Words = string:tokens(Sentence, " "),
    count_valid_words_list(Words, 0).

count_valid_words_list([], Count) -> Count;
count_valid_words_list([Word | Rest], Count) ->
    case is_valid_word(Word) of
        true -> count_valid_words_list(Rest, Count + 1);
        false -> count_valid_words_list(Rest, Count)
    end.

is_valid_word(Word) ->
    WordLen = length(Word),
    if WordLen == 0 -> false; true -> ok end,

    %% First pass: Collect information about characters in the word.
    %% Accumulator: {HyphenIndices, PunctuationIndices, HasDigit, HasOtherChar, CurrentPos}
    %% HyphenIndices: List of 0-based indices where hyphens are found.
    %% PunctuationIndices: List of 0-based indices where punctuation marks are found.
    %% HasDigit: Boolean, true if any digit is found.
    %% HasOtherChar: Boolean, true if any character other than lowercase, hyphen, or punctuation is found.
    {HyphenIndices, PunctuationIndices, HasDigit, HasOtherChar, _CurrentPos} = lists:foldl(
        fun(Char, {HI, PI, HD, HOC, CurrentPos}) ->
            NewHI = if Char == $- -> [CurrentPos | HI]; true -> HI end,
            NewPI = if is_punctuation(Char) -> [CurrentPos | PI]; true -> PI end,
            NewHD = HD or is_digit(Char),
            NewHOC = HOC or (not is_lower(Char) and Char /= $- and not is_punctuation(Char)),
            {NewHI, NewPI, NewHD, NewHOC, CurrentPos + 1}
        end,
        {[], [], false, false, 0},
        Word
    ),

    %% Apply the rules based on collected information.
    if
        HasDigit -> false; % Rule: No digits allowed.
        HasOtherChar -> false; % Rule: Only lowercase letters, hyphens, and punctuation allowed.
        length(HyphenIndices) > 1 -> false; % Rule: At most one hyphen.
        length(PunctuationIndices) > 1 -> false; % Rule: At most one punctuation mark.
        true ->
            %% Check hyphen rules: If a hyphen exists, it must be surrounded by lowercase letters.
            HyphenValid = case HyphenIndices of
                [] -> true; % No hyphen, so this rule is satisfied.
                [HIdx] ->
                    % Hyphen must not be at the beginning or end of the word.
                    % Characters immediately before and after the hyphen must be lowercase letters.
                    (HIdx > 0 and HIdx < WordLen - 1) and
                    is_lower(lists:nth(HIdx, Word)) and      % Character before the hyphen (0-based HIdx, so 1-based lists:nth(HIdx))
                    is_lower(lists:nth(HIdx + 2, Word))      % Character after the hyphen (0-based HIdx, so 1-based lists:nth(HIdx+2))
            end,

            %% Check punctuation rules: If a punctuation mark exists, it must be at the end of the word.
            PunctuationValid = case PunctuationIndices of
                [] -> true; % No punctuation, so this rule is satisfied.
                [PIdx] ->
                    % Punctuation mark must be the last character.
                    PIdx == WordLen - 1
            end,

            %% The word is valid if all individual checks pass.
            HyphenValid and PunctuationValid
    end.