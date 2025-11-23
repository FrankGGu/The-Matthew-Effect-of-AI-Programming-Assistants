-spec check_perfect_number(Num :: integer()) -> boolean().
check_perfect_number(Num) when Num =< 1 ->
    false;
check_perfect_number(Num) ->
    Sum = 1,
    Max = trunc(math:sqrt(Num)),
    check_perfect_number(Num, 2, Max, Sum).

check_perfect_number(Num, I, Max, Sum) when I > Max ->
    Sum == Num;
check_perfect_number(Num, I, Max, Sum) when Num rem I =:= 0 ->
    OtherDivisor = Num div I,
    if
        I =:= OtherDivisor -> NewSum = Sum + I;
        true -> NewSum = Sum + I + OtherDivisor
    end,
    check_perfect_number(Num, I + 1, Max, NewSum);
check_perfect_number(Num, I, Max, Sum) ->
    check_perfect_number(Num, I + 1, Max, Sum).