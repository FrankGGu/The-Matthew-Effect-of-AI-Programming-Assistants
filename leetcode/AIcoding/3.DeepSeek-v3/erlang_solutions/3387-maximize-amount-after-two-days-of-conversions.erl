-spec max_amount(Amount :: integer()) -> integer().
max_amount(Amount) ->
    case Amount of
        0 -> 0;
        1 -> 1;
        _ -> max(Amount, max_amount(Amount div 2) + max_amount(Amount div 3) + max_amount(Amount div 4))
    end.