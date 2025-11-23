-spec count_digits(Num :: integer()) -> integer().
count_digits(Num) ->
    Original = Num,
    Count = 0,
    count_digits_helper(abs(Original), Original, Count).

count_digits_helper(0, _, Count) -> Count;
count_digits_helper(N, Original, Count) ->
    Digit = N rem 10,
    if
        Digit =/= 0 andalso Original rem Digit =:= 0 ->
            count_digits_helper(N div 10, Original, Count + 1);
        true ->
            count_digits_helper(N div 10, Original, Count)
    end.