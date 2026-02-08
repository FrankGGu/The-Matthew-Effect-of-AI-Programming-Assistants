-module(solution).
-export([calculate_money/1]).

calculate_money(N) ->
    Weeks = N div 7,
    Days = N rem 7,
    MoneyFromWeeks = Weeks * (7 * (Weeks + 1) div 2),
    MoneyFromDays = Days * (Days + 1) div 2,
    MoneyFromWeeks + MoneyFromDays.