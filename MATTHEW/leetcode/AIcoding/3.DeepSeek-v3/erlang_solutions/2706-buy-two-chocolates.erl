-spec buy_choco(Prices :: [integer()], Money :: integer()) -> integer().
buy_choco(Prices, Money) ->
    Sorted = lists:sort(Prices),
    case Sorted of
        [First, Second | _] ->
            Total = First + Second,
            if
                Total =< Money -> Money - Total;
                true -> Money
            end;
        _ -> Money
    end.