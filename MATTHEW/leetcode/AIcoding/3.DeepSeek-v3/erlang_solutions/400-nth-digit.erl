-spec find_nth_digit(N :: integer()) -> integer().
find_nth_digit(N) ->
    find_nth_digit(N, 1, 9, 1).

find_nth_digit(N, Digits, Count, Start) when N > Count * Digits ->
    find_nth_digit(N - Count * Digits, Digits + 1, Count * 10, Start * 10);
find_nth_digit(N, Digits, _Count, Start) ->
    Num = Start + (N - 1) div Digits,
    DigitPos = (N - 1) rem Digits,
    integer_to_list(Num) - 48.