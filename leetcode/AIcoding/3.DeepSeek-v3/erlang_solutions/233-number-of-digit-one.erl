-spec count_digit_one(N :: integer()) -> integer().
count_digit_one(N) ->
    count_digit_one(N, 1, 0).

count_digit_one(N, M, Count) when M =< N ->
    A = N div M,
    B = N rem M,
    Current = (A + 8) div 10 * M + case A rem 10 =:= 1 of
                                      true -> B + 1;
                                      false -> 0
                                  end,
    count_digit_one(N, M * 10, Count + Current);
count_digit_one(_, _, Count) ->
    Count.