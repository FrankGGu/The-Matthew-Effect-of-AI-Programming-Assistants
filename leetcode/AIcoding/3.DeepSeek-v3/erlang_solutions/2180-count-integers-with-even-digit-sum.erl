-spec count_even(integer()) -> integer().
count_even(Num) ->
    count_even_helper(1, Num, 0).

count_even_helper(Current, Num, Count) when Current =< Num ->
    case digit_sum_even(Current) of
        true -> count_even_helper(Current + 1, Num, Count + 1);
        false -> count_even_helper(Current + 1, Num, Count)
    end;
count_even_helper(_, _, Count) ->
    Count.

digit_sum_even(N) ->
    Sum = lists:foldl(fun(D, Acc) -> D + Acc end, 0, digits(N)),
    Sum rem 2 == 0.

digits(0) -> [];
digits(N) when N > 0 -> digits(N div 10) ++ [N rem 10].