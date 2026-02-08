-module(water_bottles).
-export([num_water_bottles/2]).

num_water_bottles(NumBottles, NumExchange) ->
  num_water_bottles(NumBottles, NumExchange, 0).

num_water_bottles(EmptyBottles, NumExchange, Total) ->
  if
    EmptyBottles < NumExchange ->
      Total + EmptyBottles;
    true ->
      NewBottles = EmptyBottles div NumExchange,
      RemainingEmpty = EmptyBottles rem NumExchange,
      num_water_bottles(NewBottles + RemainingEmpty, NumExchange, Total + EmptyBottles)
  end.