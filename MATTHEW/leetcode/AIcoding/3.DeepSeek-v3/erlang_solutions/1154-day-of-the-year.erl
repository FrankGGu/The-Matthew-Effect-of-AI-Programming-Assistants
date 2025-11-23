-spec day_of_year(Date :: unicode:unicode_binary()) -> integer().
day_of_year(Date) ->
    <<Year:4/binary, "-", Month:2/binary, "-", Day:2/binary>> = Date,
    Y = binary_to_integer(Year),
    M = binary_to_integer(Month),
    D = binary_to_integer(Day),
    Days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31],
    LeapDays = case (Y rem 400 == 0) orelse ((Y rem 100 /= 0) andalso (Y rem 4 == 0)) of
        true -> 1;
        false -> 0
    end,
    AdjustedDays = case M > 2 of
        true -> lists:nth(2, Days) + LeapDays;
        false -> lists:nth(2, Days)
    end,
    NewDays = lists:sublist(Days, M - 1) ++ [AdjustedDays] ++ lists:nthtail(M, Days),
    lists:sum(lists:sublist(NewDays, M - 1)) + D.