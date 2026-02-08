-module(minimum_cost_to_set_cooking_time).
-export([min_cost/3]).

min_cost(standard_time, cooking_time, cost) ->
    min_cost(standard_time, cooking_time, cost, 0, 0).

min_cost(StandardTime, CookingTime, Cost, CurrentTime, Acc) when CurrentTime >= CookingTime ->
    Acc;
min_cost(StandardTime, CookingTime, Cost, CurrentTime, Acc) ->
    NextTime = CurrentTime + 1,
    NewAcc = Acc + Cost,
    min_cost(StandardTime, CookingTime, Cost, NextTime, NewAcc).

min_cost(StandardTime, CookingTime, Cost) ->
    min_cost(StandardTime, CookingTime, Cost, 0, 0).