-spec add_digits(Num :: integer()) -> integer().
add_digits(Num) when Num < 10 -> Num;
add_digits(Num) ->
    Sum = lists:sum([Digit - $0 || Digit <- integer_to_list(Num)]),
    add_digits(Sum).