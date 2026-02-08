-module(day_of_year).
-export([dayOfYear/1]).

dayOfYear(Date) ->
  [Year, Month, Day] = string:tokens(Date, "-"),
  Y = list_to_integer(Year),
  M = list_to_integer(Month),
  D = list_to_integer(Day),
  is_leap(Y) * leap_days(M) + non_leap_days(M) + D.

is_leap(Year) ->
  case (Year rem 4 == 0 and Year rem 100 /= 0) or Year rem 400 == 0 of
    true -> 1;
    false -> 0
  end.

leap_days(Month) ->
  case Month of
    1 -> 0;
    2 -> 31;
    3 -> 60;
    4 -> 91;
    5 -> 121;
    6 -> 152;
    7 -> 182;
    8 -> 213;
    9 -> 244;
    10 -> 274;
    11 -> 305;
    12 -> 335
  end.

non_leap_days(Month) ->
  case Month of
    1 -> 0;
    2 -> 31;
    3 -> 59;
    4 -> 90;
    5 -> 120;
    6 -> 151;
    7 -> 181;
    8 -> 212;
    9 -> 243;
    10 -> 273;
    11 -> 304;
    12 -> 334
  end.