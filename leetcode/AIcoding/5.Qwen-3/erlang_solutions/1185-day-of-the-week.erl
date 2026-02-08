-module(day_of_the_week).
-export([day_of_the_week/3]).

day_of_the_week(Year, Month, Day) ->
    Days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"],
    Date = calendar:datetime_to_gregorian_days({{Year, Month, Day}, {0, 0, 0}}),
    lists:nth(Date rem 7 + 1, Days).