-module(days_between_dates).
-export([days_between_dates/2]).

days_between_dates(Date1, Date2) ->
  days_between(date_to_days(Date1), date_to_days(Date2)).

days_between(Days1, Days2) ->
  abs(Days1 - Days2).

date_to_days(Date) ->
  {Year, Month, Day} = parse_date(Date),
  days_since_epoch(Year, Month, Day).

parse_date(Date) ->
  [YearStr, MonthStr, DayStr] = string:split(Date, "-", all),
  {list_to_integer(YearStr), list_to_integer(MonthStr), list_to_integer(DayStr)}.

days_since_epoch(Y, M, D) ->
  Y1 = Y - 1,
  365 * Y1 + Y1 div 4 - Y1 div 100 + Y1 div 400 + days_before(M) + D.

days_before(1) -> 0;
days_before(2) -> 31;
days_before(3) -> 59;
days_before(4) -> 90;
days_before(5) -> 120;
days_before(6) -> 151;
days_before(7) -> 181;
days_before(8) -> 212;
days_before(9) -> 243;
days_before(10) -> 273;
days_before(11) -> 304;
days_before(12) -> 334.