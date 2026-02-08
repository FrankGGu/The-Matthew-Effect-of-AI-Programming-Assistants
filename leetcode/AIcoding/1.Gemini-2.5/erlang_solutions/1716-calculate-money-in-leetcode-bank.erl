-module(solution).
-export([totalMoney/1]).

totalMoney(N) ->
    FullWeeks = N div 7,
    RemainingDays = N rem 7,

    MoneyFromFullWeeks = 7 * (FullWeeks * (FullWeeks + 1) div 2) + 21 * FullWeeks,

    CurrentWeekStartValue = FullWeeks + 1,
    FirstTerm = CurrentWeekStartValue,
    LastTerm = CurrentWeekStartValue + RemainingDays - 1,
    MoneyFromRemainingDays = RemainingDays * (FirstTerm + LastTerm) div 2,

    MoneyFromFullWeeks + MoneyFromRemainingDays.