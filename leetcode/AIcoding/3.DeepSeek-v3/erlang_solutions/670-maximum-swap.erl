-spec maximum_swap(Num :: integer()) -> integer().
maximum_swap(Num) ->
    Digits = integer_to_list(Num),
    MaxDigits = find_max_digits(Digits),
    swap(Digits, MaxDigits, 0).

find_max_digits(Digits) ->
    find_max_digits(Digits, length(Digits) - 1, -1, []).

find_max_digits(_Digits, -1, _Max, Acc) ->
    lists:reverse(Acc);
find_max_digits(Digits, I, Max, Acc) ->
    Digit = lists:nth(I + 1, Digits),
    CurrentMax = max(Digit, Max),
    find_max_digits(Digits, I - 1, CurrentMax, [CurrentMax | Acc]).

swap(Digits, _MaxDigits, I) when I >= length(Digits) ->
    list_to_integer(Digits);
swap(Digits, MaxDigits, I) ->
    Digit = lists:nth(I + 1, Digits),
    MaxDigit = lists:nth(I + 1, MaxDigits),
    if
        Digit < MaxDigit ->
            {SwappedDigits, _} = do_swap(Digits, I, MaxDigit),
            list_to_integer(SwappedDigits);
        true ->
            swap(Digits, MaxDigits, I + 1)
    end.

do_swap(Digits, I, MaxDigit) ->
    do_swap(Digits, I, MaxDigit, length(Digits) - 1).

do_swap(Digits, I, MaxDigit, J) ->
    Digit = lists:nth(J + 1, Digits),
    if
        Digit == MaxDigit ->
            SwappedDigits = swap_digits(Digits, I, J),
            {SwappedDigits, J};
        true ->
            do_swap(Digits, I, MaxDigit, J - 1)
    end.

swap_digits(Digits, I, J) ->
    {BeforeI, [DI | AfterI]} = lists:split(I, Digits),
    {BeforeJ, [DJ | AfterJ]} = lists:split(J, BeforeI ++ AfterI),
    BeforeJ ++ [DI | AfterJ].