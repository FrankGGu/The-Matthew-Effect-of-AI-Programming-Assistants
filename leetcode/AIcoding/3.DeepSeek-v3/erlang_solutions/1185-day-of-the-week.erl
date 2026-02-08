-spec day_of_the_week(Day :: integer(), Month :: integer(), Year :: integer()) -> unicode:unicode_binary().
day_of_the_week(Day, Month, Year) ->
    Days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"],
    M = case Month of
            1 -> 11;
            2 -> 12;
            _ -> Month - 2
        end,
    Y = if
            Month =:= 1; Month =:= 2 -> Year - 1;
            true -> Year
        end,
    C = Y div 100,
    YY = Y rem 100,
    W = (Day + trunc(2.6 * M - 0.2) + YY + YY div 4 + C div 4 - 2 * C) rem 7,
    Index = (W + 7) rem 7 + 1,
    list_to_binary(lists:nth(Index, Days)).