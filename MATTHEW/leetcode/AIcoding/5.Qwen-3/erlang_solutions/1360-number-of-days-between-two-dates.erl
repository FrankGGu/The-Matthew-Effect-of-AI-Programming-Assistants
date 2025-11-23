-module(number_of_days_between_two_dates).
-export([days_between/2]).

days_between(Date1, Date2) ->
    Date1Unix = date_to_unix(Date1),
    Date2Unix = date_to_unix(Date2),
    abs(Date1Unix - Date2Unix).

date_to_unix({Y, M, D}) ->
    SecondsPerDay = 24 * 60 * 60,
    calendar:datetime_to_gregorian_seconds({{Y, M, D}, {0, 0, 0}}) * SecondsPerDay.