-module(solution).
-export([count_substrings_divisible_by_last_digit/1]).

count_substrings_divisible_by_last_digit(S) ->
    count_substrings_divisible_by_last_digit(S, 0, 0).

count_substrings_divisible_by_last_digit([], _, Count) ->
    Count;
count_substrings_divisible_by_last_digit([H | T], Index, Count) ->
    LastDigit = H rem 10,
    if
        LastDigit == 0 ->
            count_substrings_divisible_by_last_digit(T, Index + 1, Count + length(T) + 1);
        true ->
            count_substrings_divisible_by_last_digit(T, Index + 1, Count + count_valid_substrings(H, T, LastDigit))
    end.

count_valid_substrings(_, [], _) ->
    0;
count_valid_substrings(FirstChar, [H | T], LastDigit) ->
    Num = FirstChar * 10 + H,
    if
        Num rem LastDigit == 0 ->
            1 + count_valid_substrings(FirstChar, T, LastDigit);
        true ->
            count_valid_substrings(FirstChar, T, LastDigit)
    end.