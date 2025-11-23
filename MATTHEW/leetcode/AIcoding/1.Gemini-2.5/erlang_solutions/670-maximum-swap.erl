-module(maximum_swap).
-export([maximum_swap/1]).

maximum_swap(Num) ->
    Digits = num_to_digits(Num),
    Len = length(Digits),
    maximum_swap_loop(Digits, Len, 0).

maximum_swap_loop(Digits, Len, I) when I < Len ->
    CurrentDigit = lists:nth(I + 1, Digits),

    % Pass 1: Find the maximum digit to the right of current position I
    MaxDigit = find_max_digit_right(Digits, I + 1, Len - 1, -1),

    % If a larger digit is found to the right, a swap might be beneficial
    if MaxDigit > CurrentDigit ->
        % Pass 2: Find the rightmost index of this MaxDigit
        MaxRightIdx = find_rightmost_idx_of_max_digit(Digits, MaxDigit, Len - 1, I + 1),

        % Perform the swap: Digits[I] with Digits[MaxRightIdx]
        % Note: lists:nth and lists:replace_nth use 1-based indexing.
        % I and MaxRightIdx are 0-based, so add 1.
        SwappedDigits1 = lists:replace_nth(I + 1, lists:nth(MaxRightIdx + 1, Digits), Digits),
        SwappedDigits2 = lists:replace_nth(MaxRightIdx + 1, CurrentDigit, SwappedDigits1),

        digits_to_num(SwappedDigits2);
    true ->
        % No beneficial swap for this position, move to the next digit
        maximum_swap_loop(Digits, Len, I + 1)
    end;
maximum_swap_loop(Digits, _Len, _I) ->
    % No swap found after checking all positions, return the original number (as digits)
    digits_to_num(Digits).

num_to_digits(Num) ->
    [C - $0 || C <- integer_to_list(Num)].

digits_to_num(Digits) ->
    list_to_integer([C + $0 || C <- Digits]).

find_max_digit_right(Digits, CurrentIdx, EndIdx, CurrentMax) when CurrentIdx =< EndIdx ->
    Digit = lists:nth(CurrentIdx + 1, Digits),
    NewMax = max(CurrentMax, Digit),
    find_max_digit_right(Digits, CurrentIdx + 1, EndIdx, NewMax);
find_max_digit_right(_Digits, _CurrentIdx, _EndIdx, CurrentMax) ->
    CurrentMax.

find_rightmost_idx_of_max_digit(Digits, MaxDigit, CurrentIdx, StopIdx) when CurrentIdx >= StopIdx ->
    Digit = lists:nth(CurrentIdx + 1, Digits),
    if Digit == MaxDigit ->
        CurrentIdx; % Found the rightmost occurrence
    true ->
        find_rightmost_idx_of_max_digit(Digits, MaxDigit, CurrentIdx - 1, StopIdx)
    end;
find_rightmost_idx_of_max_digit(_Digits, _MaxDigit, _CurrentIdx, _StopIdx) ->
    % This case should ideally not be reached if MaxDigit was found in the first pass
    % and StopIdx is correctly set to I + 1.
    -1.