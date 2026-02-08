-spec maximum_value(integer()) -> integer().
maximum_value(N) ->
    maximum_value(N, 0, 0, 0).

maximum_value(0, Max1, Max2, Max3) ->
    Max1 * Max2 * Max3;
maximum_value(N, Max1, Max2, Max3) ->
    Digit = N rem 10,
    NewMax1 = max(Max1, Digit),
    NewMax2 = if
        Digit < Max1 -> max(Max2, Digit);
        true -> Max2
    end,
    NewMax3 = if
        Digit < Max2 -> max(Max3, Digit);
        true -> Max3
    end,
    maximum_value(N div 10, NewMax1, NewMax2, NewMax3).