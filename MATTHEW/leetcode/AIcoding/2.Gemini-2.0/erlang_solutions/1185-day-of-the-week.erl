-module(day_of_the_week).
-export([dayOfTheWeek/3]).

dayOfTheWeek(Day, Month, Year) ->
  A = [0, 3, 2, 5, 0, 3, 5, 1, 4, 6, 2, 4],
  Y = Year - (Month < 3),
  D = (Y + Y div 4 - Y div 100 + Y div 400 + A !! (Month - 1) + Day) rem 7,
  ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"] !! D.