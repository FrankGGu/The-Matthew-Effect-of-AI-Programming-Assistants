-module(solution).
-export([originalDigits/1]).

originalDigits(S) ->
    % 1. Count character frequencies
    CharCounts = lists:foldl(
        fun(C, Acc) ->
            Idx = C - $a,
            lists:replace_at(Idx + 1, lists:nth(Idx + 1, Acc) + 1, Acc)
        end,
        lists:duplicate(26, 0),
        S
    ),

    % Initialize digit counts for 0-9
    DigitCounts = lists:duplicate(10, 0),

    % 2. Count digits with unique identifying characters
    % zero: 'z'
    Count0 = lists:nth($z - $a + 1, CharCounts),
    DigitCounts1 = lists:replace_at(1, Count0, DigitCounts), % Index 1 for digit 0

    % two: 'w'
    Count2 = lists:nth($w - $a + 1, CharCounts),
    DigitCounts2 = lists:replace_at(3, Count2, DigitCounts1), % Index 3 for digit 2

    % four: 'u'
    Count4 = lists:nth($u - $a + 1, CharCounts),
    DigitCounts3 = lists:replace_at(5, Count4, DigitCounts2), % Index 5 for digit 4

    % six: 'x'
    Count6 = lists:nth($x - $a + 1, CharCounts),
    DigitCounts4 = lists:replace_at(7, Count6, DigitCounts3), % Index 7 for digit 6

    % eight: 'g'
    Count8 = lists:nth($g - $a + 1, CharCounts),
    DigitCounts5 = lists:replace_at(9, Count8, DigitCounts4), % Index 9 for digit 8

    % 3. Count digits using characters that become unique after deducting known digits
    % three: 'h' (in 'three', 'eight')
    Count3 = lists:nth($h - $a + 1, CharCounts) - Count8,
    DigitCounts6 = lists:replace_at(4, Count3, DigitCounts5), % Index 4 for digit 3

    % five: 'f' (in 'four', 'five')
    Count5 = lists:nth($f - $a + 1, CharCounts) - Count4,
    DigitCounts7 = lists:replace_at(6, Count5, DigitCounts6), % Index 6 for digit 5

    % seven: 's' (in 'six', 'seven')
    Count7 = lists:nth($s - $a + 1, CharCounts) - Count6,
    DigitCounts8 = lists:replace_at(8, Count7, DigitCounts7), % Index 8 for digit 7

    % 4. Count remaining digits
    % one: 'o' (in 'zero', 'one', 'two', 'four')
    Count1 = lists:nth($o - $a + 1, CharCounts) - Count0 - Count2 - Count4,
    DigitCounts9 = lists:replace_at(2, Count1, DigitCounts8), % Index 2 for digit 1

    % nine: 'i' (in 'five', 'six', 'eight', 'nine')
    Count9 = lists:nth($i - $a + 1, CharCounts) - Count5 - Count6 - Count8,
    FinalDigitCounts = lists:replace_at(10, Count9, DigitCounts9), % Index 10 for digit 9

    % 5. Construct the result string in non-decreasing order
    FinalStringChars = lists:foldl(
        fun(Digit, Acc) ->
            Count = lists:nth(Digit + 1, FinalDigitCounts),
            Acc ++ lists:duplicate(Count, $0 + Digit)
        end,
        [],
        lists:seq(0, 9) % Iterate from 0 to 9 to build the string in order
    ).