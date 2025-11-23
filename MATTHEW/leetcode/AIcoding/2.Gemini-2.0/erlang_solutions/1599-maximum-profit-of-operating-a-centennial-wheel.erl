-module(centennial_wheel).
-export([solve/1]).

solve(Customers) ->
  solve(Customers, 0, 0, 0, 0).

solve([], Boarded, TotalCost, CurrentWait, MaxProfit) ->
  if
    CurrentWait == 0 ->
      MaxProfit;
    true ->
      Boarding = min(CurrentWait, 4),
      NewBoarded = Boarded + Boarding,
      NewCost = TotalCost + Boarding * 10 - 90,
      NewProfit = max(MaxProfit, NewCost),
      NewWait = CurrentWait - Boarding,
      solve([], NewBoarded, NewCost, NewWait, NewProfit)
  end.

solve([Customer|Rest], Boarded, TotalCost, CurrentWait, MaxProfit) ->
  NewWait = CurrentWait + Customer,
  Boarding = min(NewWait, 4),
  NewBoarded = Boarded + Boarding,
  NewCost = TotalCost + Boarding * 10 - 90,
  NewProfit = max(MaxProfit, NewCost),
  NewWait2 = NewWait - Boarding,
  solve(Rest, NewBoarded, NewCost, NewWait2, NewProfit).