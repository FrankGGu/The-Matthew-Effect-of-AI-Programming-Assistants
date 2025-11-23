-spec total_money(N :: integer()) -> integer().
total_money(N) ->
    Weeks = N div 7,
    Days = N rem 7,
    (28 * Weeks + 7 * Weeks * (Weeks - 1) div 2) + ((Weeks + 1 + Weeks + Days) * Days div 2).