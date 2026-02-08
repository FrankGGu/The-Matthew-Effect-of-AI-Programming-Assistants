-module(reducing_dishes).
-export([max_satisfaction/1]).

max_satisfaction(satisfaction) ->
  lists:reverse(lists:sort(satisfaction))
  |> calculate_max_satisfaction(0, 0).

calculate_max_satisfaction([], CurrentSum, Time) ->
  CurrentSum;
calculate_max_satisfaction([Dish | Rest], CurrentSum, Time) ->
  NewSum = CurrentSum + (Dish * (Time + 1)),
  if
    NewSum > CurrentSum ->
      calculate_max_satisfaction(Rest, NewSum, Time + 1);
    true ->
      CurrentSum
  end.