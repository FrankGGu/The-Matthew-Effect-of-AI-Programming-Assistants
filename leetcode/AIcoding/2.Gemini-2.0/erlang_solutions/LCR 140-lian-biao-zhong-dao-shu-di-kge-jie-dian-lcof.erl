-module(training_plan_ii).
-export([number_of_weeks/1]).

number_of_weeks(calories) ->
  number_of_weeks(calories, 0, 0).

number_of_weeks(0, Weeks, _) ->
  Weeks;
number_of_weeks(Calories, Weeks, Day) when Day < 7 ->
  NewCalories = Calories - (Day + 1),
  case NewCalories < 0 of
    true ->
      Weeks;
    false ->
      number_of_weeks(NewCalories, Weeks, Day + 1)
  end;
number_of_weeks(Calories, Weeks, 7) ->
  number_of_weeks(Calories, Weeks + 1, 0).