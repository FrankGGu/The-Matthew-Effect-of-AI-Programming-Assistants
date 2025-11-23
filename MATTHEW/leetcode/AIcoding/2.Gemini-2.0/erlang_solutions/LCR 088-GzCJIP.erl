-module(min_cost_climbing_stairs).
-export([min_cost_climbing_stairs/1]).

min_cost_climbing_stairs(Cost) ->
  N = length(Cost),
  min_cost_climbing_stairs_helper(Cost, N).

min_cost_climbing_stairs_helper(Cost, N) ->
  Cost1 = lists:nth(1, Cost),
  Cost2 = lists:nth(2, Cost),
  min_cost_climbing_stairs_helper(Cost, N, Cost1, Cost2, 3).

min_cost_climbing_stairs_helper(_, N, Cost1, Cost2, N+1) ->
  min(Cost1, Cost2);
min_cost_climbing_stairs_helper(Cost, N, Cost1, Cost2, I) ->
  CostI = lists:nth(I, Cost),
  NewCost1 = Cost2,
  NewCost2 = min(Cost1, Cost2) + CostI,
  min_cost_climbing_stairs_helper(Cost, N, NewCost1, NewCost2, I+1).