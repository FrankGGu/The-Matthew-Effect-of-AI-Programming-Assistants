-spec days_between_dates(Date1 :: unicode:unicode_binary(), Date2 :: unicode:unicode_binary()) -> integer().
days_between_dates(Date1, Date2) ->
    Days1 = days_since_epoch(Date1),
    Days2 = days_since_epoch(Date2),
    abs(Days1 - Days2).

days_since_epoch(Date) ->
    [Y, M, D] = binary:split(Date, <<"-">>, [global]),
    Year = binary_to_integer(Y),
    Month = binary_to_integer(M),
    Day = binary_to_integer(D),
    Total = 0,
    Total1 = Total + (Year - 1971) * 365,
    Total2 = Total1 + (Year - 1969) div 4,
    Total3 = Total2 + days_in_months(Month - 1, Year),
    Total3 + Day.

days_in_months(Month, Year) ->
    Days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31],
    IsLeap = case Year rem 400 of
        0 -> true;
        _ -> case Year rem 100 of
            0 -> false;
            _ -> case Year rem 4 of
                0 -> true;
                _ -> false
            end
        end
    end,
    AdjustedDays = case IsLeap of
        true -> lists:sublist(Days, Month) ++ [29] ++ lists:nthtail(Month + 1, Days);
        false -> Days
    end,
    lists:sum(lists:sublist(AdjustedDays, Month)).