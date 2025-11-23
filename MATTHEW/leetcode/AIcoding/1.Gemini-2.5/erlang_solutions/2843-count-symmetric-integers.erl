-spec countSymmetricIntegers(Low :: integer(), High :: integer()) -> integer().
countSymmetricIntegers(Low, High) ->
    count_symmetric_integers_recursive(Low, High, 0).

count_symmetric_integers_recursive(N, High, Acc) when N > High ->
    Acc;
count_symmetric_integers_recursive(N, High, Acc) ->
    NewAcc = if is_symmetric(N) -> Acc + 1;
               true -> Acc
             end,
    count_symmetric_integers_recursive(N + 1, High, NewAcc).

is_symmetric(N) ->
    Digits = [C - $0 || C <- integer_to_list(N)],
    Len = length(Digits),
    if
        Len rem 2 == 0 ->
            HalfLen = Len div 2,
            {FirstHalf, SecondHalf} = lists:split(HalfLen, Digits),
            lists:sum(FirstHalf) == lists:sum(SecondHalf);
        true ->
            false
    end.