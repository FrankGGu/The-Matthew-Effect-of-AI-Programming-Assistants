-spec alternate_digit_sum(N :: integer()) -> integer().
alternate_digit_sum(N) ->
    Digits = integer_to_list(abs(N)),
    Sum = lists:foldl(fun(D, {Acc, Sign}) ->
                          {Acc + (D - $0) * Sign, -Sign}
                      end, {0, 1}, Digits),
    element(1, Sum).